## POST actions in Instagram internal API

import std/asyncdispatch
from std/httpcore import HttpGet, HttpPost

from std/json import parseJson, `{}`, getBool, getStr
from std/strutils import join

import pkg/jsony

import instagram/core
import instagram/api/types/user
import instagram/api/types/post
import instagram/api/types/friendships
import instagram/api/types/followersAndFollowing

proc follow*(
  ig: Instagram;
  userId: string or IgUser or IgFollowersUser
) {.async.} =
  ## Follows the user id provided
  ## Error will raise an exception
  when userId is IgUser or userId is IgFollowersUser:
    let userId = userId.id
  let
    body = "container_module=profile&nav_chain=PolarisProfileRoot:profilePage:1:via_cold_start&user_id=" & userId
    raw = await ig.request(HttpPost,
                           endpoint("friendships/create/$#/", userId),
                           body)
    resp = raw.fromJson IgFriendshipStatusResponse
  if resp.status != "ok":
    raise newException(IgException, "Cannot follow user '" & userId & "'. Raw:" & raw)

proc unfollow*(
  ig: Instagram;
  userId: string or IgUser or IgFollowersUser
) {.async.} =
  ## Unfollows the user id provided
  ## Error will raise an exception
  when userId is IgUser or userId is IgFollowersUser:
    let userId = userId.id
  let
    body = "container_module=profile&nav_chain=PolarisProfileRoot:profilePage:1:via_cold_start&user_id=" & userId
    raw = await ig.request(HttpPost,
                           endpoint("friendships/destroy/$#/", userId),
                           body)
    resp = raw.fromJson IgFriendshipStatusResponse
  if resp.status != "ok":
    raise newException(IgException, "Cannot unfollow user '" & userId & "'. Raw:" & raw)


proc like*(
  ig: Instagram;
  postId: string or IgPost
) {.async.} =
  ## Likes the provided post
  ## Error will raise an exception
  when postId is IgPost:
    let postId = postId.id
  let
    raw = await ig.request(HttpPost, endpoint("web/likes/$#/like/", postId))
    json = parseJson raw
  if json{"status"}.getStr != "ok":
    raise newException(IgException, "Cannot like post '" & postId & "'. Raw:" & raw)

proc unlike*(
  ig: Instagram;
  postId: string or IgPost
) {.async.} =
  ## Likes the provided post
  ## Error will raise an exception
  when postId is IgPost:
    let postId = postId.id
  let
    raw = await ig.request(HttpPost, endpoint("web/likes/$#/unlike/", postId))
    json = parseJson raw
  if json{"status"}.getStr != "ok":
    raise newException(IgException, "Cannot like post '" & postId & "'. Raw:" & raw)


proc friendships*(
  ig: Instagram;
  userIds: seq[string] or seq[IgUser] or seq[IgFollowersUser]
): Future[IgFriendshipStatuses] {.async.} =
  ## Get the friendship status of given user IDs
  ## Error will raise an exception
  var ids: seq[string]
  for userId in userIds:
    when userId is IgUser or userId is IgFollowersUser:
      ids.add userId.id
    elif userId is string:
      ids.add userId
  let
    raw = await ig.request(HttpPost, "friendships/show_many/",
                            "user_ids=" & ids.join ",")
    data = raw.fromJson IgFriendshipStatusesResponse
  if data.status != "ok":
    raise newException(IgException, "Cannot get friendships of '" & ids.join "," & "'. Raw:" & raw)
  result = data.friendshipStatuses
