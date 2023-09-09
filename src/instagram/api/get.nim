## POST actions in Instagram internal API

import std/asyncdispatch
from std/httpcore import HttpGet, HttpPost

import pkg/jsony

import instagram/core

import instagram/types/api/user
import instagram/types/api/post
import instagram/types/api/feed
import instagram/types/api/followersAndFollowing

proc user*(ig: Instagram; username: string): Future[IgUser] {.async.} =
  ## Gets instagram user from their internal API
  let
    json = await ig.request(HttpGet, endpoint("users/web_profile_info/?username=$#", username))
    resp = json.fromJson IgUserResponse
  result = resp.data.user
  result.status = resp.status
  result.message = resp.message


proc followers*(
  ig: Instagram;
  userId: string or IgUser; ## User ID or User
  nextMaxId: string or IgFollowersAndFollowing = ""; ## Next max ID or Followers
  limit = 12
): Future[IgFollowersAndFollowing] {.async.} =
  ## Gets the user followers
  when userId is IgUser:
    let userId = userId.id
  when nextMaxId is IgFollowersAndFollowing:
    let nextMaxId = nextMaxId.nextMaxId

  let json = await ig.request(HttpGet, endpoint("friendships/$#/followers/?count=$#&max_id=$#&search_surface=follow_list_page",
                              userId, $limit,
                              if nextMaxId.len > 0: nextMaxId else: ""))
  result = json.fromJson IgFollowersAndFollowing

proc following*(
  ig: Instagram;
  userId: string or IgUser; ## User ID or User
  nextMaxId: string or IgFollowersAndFollowing = ""; ## Next max ID or Followers
  limit = 12
): Future[IgFollowersAndFollowing] {.async.} =
  ## Gets the user following
  when userId is IgUser:
    let userId = userId.id
  when nextMaxId is IgFollowersAndFollowing:
    let nextMaxId = nextMaxId.nextMaxId

  let json = await ig.request(HttpGet, endpoint("friendships/$#/following/?count=$#&max_id=$#&search_surface=follow_list_page",
                              userId, $limit,
                              if nextMaxId.len > 0: nextMaxId else: ""))
  result = json.fromJson IgFollowersAndFollowing


proc post*(ig: Instagram; postId: string): Future[IgPost] {.async.} =
  ## Gets instagram user from their internal API
  let json = await ig.request(HttpGet, endpoint("media/$#/comments/?can_support_threading=true&permalink_enabled=false", postId))
  result = json.fromJson IgPost


proc feed*(
  ig: Instagram;
  userId: string or IgUser or IgFollowersUser; ## or IgUser to get the id
  nextMaxId: string or IgFeed = ""; ## or IgFeed
  limit = 12
): Future[IgFeed] {.async.} =
  ## Gets the Instagram feed of specific user
  when userId is IgUser or userId is IgFollowersUser:
    let userId = userId.id
  when nextMaxId is IgFeed:
    let nextMaxId = nextMaxId.nextMaxId
  let json = await ig.request(HttpGet, endpoint("feed/user/$#/?count=$#&max_id=$#", userId,
                              limit, nextMaxId))
  result = json.fromJson IgFeed
