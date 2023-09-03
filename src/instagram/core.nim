import std/asyncdispatch
from std/uri import parseUri, `$`
from std/strutils import `%`

import pkg/unifetch
from pkg/util/forStr import between

type
  InstagramTooManyRequests* = ref object of Exception
    ## Rate limit exceeded, provide the cookies

type
  Instagram* = ref object
    appId: string ## X-IG-App-ID
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

proc newInstagram*(cookies = ""): Future[Instagram] {.async.} =
  ## Creates new Instagram instance
  new result
  result.cookies = cookies
  await setupCodes result

proc get*(ig; endpoint: string): Future[string] {.async.} =
  ## Requests to Instagram internal api
  let
    uni = newUniClient(headers = newHttpHeaders({
      "X-IG-App-ID": ig.appId,
      "X-Requested-With": "XMLHttpRequest",
      "Alt-Used": instagramUrl.hostname,
      "Referer": $instagramUrl,
      "Cookie": ig.cookies
    }))
    req = await uni.get apiUrl / endpoint
  close uni

  result = req.body

func endpoint*(path: string; args: varargs[string, `$`]): string =
  path % args

when isMainModule:
  import std/json

  const cookies = staticRead "../../developmentcookies.txt"
  let ig = waitFor newInstagram cookies
  # let data = waitFor ig.get "media/3140623659379585160/comments/?can_support_threading=true&permalink_enabled=false"
  # let data = waitFor ig.get "users/web_profile_info/?username=microsoft"
  let data = waitFor ig.get "friendships/57011964897/followers/?count=12&search_surface=follow_list_page"
  echo data
