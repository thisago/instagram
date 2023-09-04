## POST actions in Instagram internal API

import std/asyncdispatch
from std/httpcore import HttpGet, HttpPost

from std/json import parseJson, `{}`, getBool, getStr
from std/strutils import join

import pkg/jsony

import instagram/core
import instagram/api/types/user
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
    json = parseJson await ig.request(HttpPost,
                                      endpoint("friendships/create/$#/", userId),
                                      body)
  if not json{"friendship_status", "following"}.getBool:
    raise newException(IgException, "Cannot follow user '" & userId & "'")

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
    json = parseJson await ig.request(HttpPost,
                                      endpoint("friendships/destroy/$#/", userId),
                                      body)
  if json{"friendship_status", "following"}.getBool:
    raise newException(IgException, "Cannot unfollow user '" & userId & "'")

import instagram/api/types/post

proc like*(
  ig: Instagram;
  postId: string or IgPost
) {.async.} =
  ## Likes the provided post
  ## Error will raise an exception
  when postId is IgPost:
    let postId = postId.id
  let json = parseJson await ig.request(HttpPost, endpoint("web/likes/$#/like/", postId))
  if json{"status"}.getStr != "ok":
    raise newException(IgException, "Cannot like post '" & postId & "'")

proc unlike*(
  ig: Instagram;
  postId: string or IgPost
) {.async.} =
  ## Likes the provided post
  ## Error will raise an exception
  when postId is IgPost:
    let postId = postId.id
  let json = parseJson await ig.request(HttpPost, endpoint("web/likes/$#/unlike/", postId))
  if json{"status"}.getStr != "ok":
    raise newException(IgException, "Cannot like post '" & postId & "'")

import instagram/api/types/friendships

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
    json = await ig.request(HttpPost, "friendships/show_many/",
                            "user_ids=" & ids.join ",")
    data = json.fromJson IgFriendshipStatusResponse
  if data.status != "ok":
    raise newException(IgException, "Cannot get friendships of '" & ids.join "," & "'")
  result = data.friendshipStatuses
