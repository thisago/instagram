import std/asyncdispatch
from std/uri import parseUri, `$`
from std/strutils import `%`, contains
from std/json import parseJson, `{}`, getStr

import pkg/unifetch
from pkg/util/forStr import between

type
  IgTooManyRequests* = object of IOError
    ## Rate limit exceeded, provide the cookies
    ## TODO: Implement
  IgMissingCsrf* = object of IOError
    ## The request depends on CSRF Token, but it's not present
  IgAuthRequired* = object of IOError
    ## The request cannot be done without authentication cookies
  IgException* = object of IOError
    ## Generic error occurred

type
  Instagram* = ref object
    appId: string ## X-IG-App-ID
    csrfToken: string ## X-CSRFToken
    cookies*: string ## Optional, but without authentication there's a rate limit

const
  instagramUrl = parseUri "https://www.instagram.com"
  apiUrl = instagramUrl / "api/v1"

using
  ig: Instagram

proc prepare*(ig) {.async.} =
  ## Adds to the provided mutable Instagram instance the required codes for API
  ## request extracted from a Instagram page
  ##
  ## Need to run when `IgMissingCsrf` is raised
  let
    uni = newUniClient()
    req = await uni.get instagramUrl
    body = req.body
  close uni

  ig.appId = body.between("X-IG-App-ID\":\"", "\"")
  ig.csrfToken = body.between("\\\"csrf_token\\\":\\\"", "\\\"")

proc newInstagram*(cookies = ""): Future[Instagram] {.async.} =
  ## Creates new Instagram instance
  new result
  result.cookies = cookies
  if cookies.len > 0:
    if cookies[^1] != ';':
      result.cookies.add ";"
    result.cookies.add "csrftoken="

  await prepare result

# Internal proc
proc request*(ig; httpMethod: HttpMethod; endpoint: string; body = ""): Future[string] {.async.} =
  ## Requests to Instagram internal api
  if httpMethod == HttpPost and ig.cookies.len < 100:
    raise newException(IgAuthRequired, "In order to proceed, provide your Instagram cookies to `newInstagram` procedure.")
  let
    uni = newUniClient(headers = newHttpHeaders({
      "X-IG-App-ID": ig.appId,
      "X-CSRFToken": ig.csrfToken,
      "X-Requested-With": "XMLHttpRequest",
      "Alt-Used": instagramUrl.hostname,
      "Origin": $instagramUrl,
      "Referer": $instagramUrl,
      "Content-Type": "application/x-www-form-urlencoded",
      "Cookie": ig.cookies & ig.csrfToken
    }))
    req = await uni.request(apiUrl / endpoint, httpMethod, body, nil)
  close uni

  result = req.body

  if "status\":\"fail" in req.body:
    let error = req.body.parseJson{"message"}.getStr
    case error:
    of "CSRF token missing or incorrect":
      raise newException(IgMissingCsrf, error & " Raw:\l" & req.body)
    else:
      raise newException(IgException, error & " Raw:\l" & req.body)
  elif req.body.len == 0:
    raise newException(IgException, "Instagram sent a blank response. Raw:\l" & req.body)

  writeFile("out.json", req.body)

func endpoint*(path: string; args: varargs[string, `$`]): string =
  path % args

when isMainModule:
  const cookies = staticRead "../../developmentcookies.txt"
  # let ig = waitFor newInstagram ""
  let ig = waitFor newInstagram cookies
  echo waitFor ig.request(HttpPost, "friendships/create/524549267")
