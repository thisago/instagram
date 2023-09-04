## POST actions in Instagram internal API

import std/asyncdispatch
from std/httpcore import HttpGet, HttpPost

from std/json import parseJson, `{}`, getBool

import instagram/core
import instagram/api/types/user

proc follow*(
  ig: Instagram;
  userId: string or IgUser
) {.async.} =
  ## Follows the user id provided
  ## Error will raise an exception
  when userId is IgUser:
    let userId = userId.id
  let
    body = "container_module=profile&nav_chain=PolarisProfileRoot:profilePage:1:via_cold_start&user_id=" & userId
    json = parseJson await ig.request(HttpPost,
                                      endpoint("friendships/create/$#/", userId),
                                      body)
  if not json{"friendship_status", "following"}.getBool:
    raise newException(IgException, "Cannot follow user '" & userId & "'")

proc unfollow*(
  ig: Instagram;
  userId: string or IgUser
) {.async.} =
  ## Unfollows the user id provided
  ## Error will raise an exception
  when userId is IgUser:
    let userId = userId.id
  let
    body = "container_module=profile&nav_chain=PolarisProfileRoot:profilePage:1:via_cold_start&user_id=" & userId
    json = parseJson await ig.request(HttpPost,
                                      endpoint("friendships/destroy/$#/", userId),
                                      body)
  if json{"friendship_status", "following"}.getBool:
    raise newException(IgException, "Cannot unfollow user '" & userId & "'")
