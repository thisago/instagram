import std/asyncdispatch
from std/uri import parseUri, `$`
from std/strutils import `%`

import pkg/unifetch
from pkg/util/forStr import between

type
  InstagramTooManyRequests* = ref object of IOError
    ## Rate limit exceeded, provide the cookies
    ## TODO: Implement

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

proc setupCodes(ig) {.async.} =
  ## Adds to the provided mutable Instagram instance the required codes for API
  ## request extracted from a Instagram page
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
  await setupCodes result

# Don't export as library procs
proc get*(ig; endpoint: string): Future[string] {.async.} =
  ## Requests to Instagram internal api
  let
    uni = newUniClient(headers = newHttpHeaders({
      "X-IG-App-ID": ig.appId,
      "X-CSRFToken": ig.csrfToken,
      "X-Requested-With": "XMLHttpRequest",
      "Alt-Used": instagramUrl.hostname,
      "Referer": $instagramUrl,
      "Cookie": ig.cookies
    }))
    req = await uni.get apiUrl / endpoint
  close uni

  result = req.body
  # writeFile("out.json", req.body)

func endpoint*(path: string; args: varargs[string, `$`]): string =
  path % args

when isMainModule:
  const cookies = staticRead "../../developmentcookies.txt"
  let ig = waitFor newInstagram cookies
  echo ig[]
