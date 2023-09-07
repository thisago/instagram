import std/asyncdispatch
from std/uri import parseUri, `$`
from std/strutils import `%`, contains
from std/json import parseJson, `{}`, getStr, JsonParsingError
from std/httpcore import HttpHeaders

import pkg/jsony

import pkg/unifetch
from pkg/util/forStr import between

const igDebugReqFile {.strdefine.} = ""

# import instagram/parsing
import types/xigSharedData

proc renameHook*[T: object](v: var T; fieldName: var string) =
  if fieldName.len > 2 and fieldName[0..1] == "__":
    fieldName = fieldName[2..^1]

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
    cookies*: string ## Optional, but without authentication there's a rate limit
    sharedData*: XigSharedData
    headers: HttpHeaders

const
  instagramUrl = parseUri "https://www.instagram.com"
  apiUrl = instagramUrl / "api/v1"

using
  ig: Instagram

proc parseSharedData(body: string): XigSharedData =
  ## Parses XIGSharedData from Instagram HTML
  var json = getStr parseJson "\"" & body.between("raw\":\"", "\",\"native\"") & "\""
  if json.len == 0:
    return
  result = json.fromJson XigSharedData

proc prepare*(ig) {.async.} =
  ## Adds to the provided mutable Instagram instance the required codes for API
  ## request extracted from a Instagram page
  ##
  ## Need to run when `IgMissingCsrf` is raised
  let
    uni = newUniClient(headers = ig.headers)
    req = await uni.get instagramUrl
    body = req.body
  close uni

  ig.appId = body.between("X-IG-App-ID\":\"", "\"")

  ig.sharedData = parseSharedData body

proc newInstagram*(cookies = ""): Future[Instagram] {.async.} =
  ## Creates new Instagram instance
  new result
  result.cookies = cookies
  result.headers = newHttpHeaders({
    "X-Requested-With": "XMLHttpRequest",
    # "Alt-Used": instagramUrl.hostname,
    "Origin": $instagramUrl,
    "Referer": $instagramUrl,
  })

  if cookies.len > 0:
    result.headers.add("Cookie", result.cookies)

  await prepare result

  result.headers.add("X-IG-App-ID", result.appId)

  if result.sharedData.csrfToken.len > 0:
    result.headers.add("X-CSRFToken", result.sharedData.csrfToken)
    if cookies.len > 0:
      if cookies[^1] != ';':
        result.cookies.add ";"
      result.cookies.add "csrftoken=" & result.sharedData.csrfToken

  if cookies.len > 0:
    result.headers.add("Cookie", result.cookies)

func isLogged*(ig): bool =
  ## Checks if this Instagram instance is logged in
  result = not ig.sharedData.config.viewer.isNil

# Internal proc
proc request*(ig; httpMethod: HttpMethod; endpoint: string; body = ""): Future[string] {.async.} =
  ## Requests to Instagram internal api
  if httpMethod == HttpPost and not ig.isLogged:
    raise newException(IgAuthRequired, "In order to proceed, provide your Instagram cookies to `newInstagram` procedure.")
  let uni = newUniClient(headers = ig.headers)
  if httpMethod == HttpPost:
    uni.headers["Content-Type"] = "application/x-www-form-urlencoded"

  let req = await uni.request(apiUrl / endpoint, httpMethod, body, nil)
  close uni

  result = req.body

  when igDebugReqFile.len > 0:
    writeFile(igDebugReqFile, req.body)

  if "status\":\"fail" in req.body:
    try:
      let error = req.body.parseJson{"message"}.getStr
      case error:
      of "CSRF token missing or incorrect":
        raise newException(IgMissingCsrf, error & " Raw:\l" & req.body)
      else:
        raise newException(IgException, error & " Raw:\l" & req.body)
    except JsonParsingError:
      raise newException(IgException, "Cannot parse JSON response. Check your sesssion. Raw:\l" & req.body)
  elif req.body.len == 0:
    raise newException(IgException, "Instagram sent a blank response. Check your session. Raw:\l" & req.body)

func endpoint*(path: string; args: varargs[string, `$`]): string =
  path % args

when isMainModule:
  import json
  const cookies = staticRead "../../developmentcookies.txt"
  # let ig = waitFor newInstagram ""
  let ig = waitFor newInstagram cookies
  echo pretty %*ig.sharedData[]
