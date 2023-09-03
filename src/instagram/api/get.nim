import std/asyncdispatch

import pkg/jsony

import instagram/core

import instagram/api/types/user
export user except IgUserResponse
import instagram/api/types/followers
export followers

proc user*(ig: Instagram; username: string): Future[IgUser] {.async.} =
  ## Gets instagram user from their internal API
  let
    json = await ig.get endpoint("users/web_profile_info/?username=$#", username)
    resp = json.fromJson IgUserResponse
  result = resp.data.user
  result.status = resp.status
  result.message = resp.message

proc followers*(
  ig: Instagram;
  userId: string or IgUser; ## User ID or User
  nextMaxId: string or IgFollowers = ""; ## Next max ID or Followers
  limit = 12
): Future[IgFollowers] {.async.} =
  ## Gets the user followers
  when userId is IgUser:
    let userId = userId.id
  when nextMaxId is IgFollowers:
    let nextMaxId = nextMaxId.nextMaxId

  let json = await ig.get endpoint("friendships/$#/followers/?count=$#&max_id=$#&search_surface=follow_list_page",
                                   userId, $limit,
                                   if nextMaxId.len > 0: nextMaxId else: $limit)
  result = json.fromJson IgFollowers

import instagram/api/types/post
export post

proc post*(ig: Instagram; postId: string): Future[IgPost] {.async.} =
  ## Gets instagram user from their internal API
  let json = await ig.get endpoint("media/$#/comments/?can_support_threading=true&permalink_enabled=false", postId)
  result = json.fromJson IgPost

import instagram/api/types/feed
export feed

proc feed*(
  ig: Instagram;
  userId: string or IgUser; ## or IgUser to get the id
  nextMaxId: string or IgFeed = ""; ## or IgFeed
  limit = 12
): Future[IgFeed] {.async.} =
  ## Gets the Instagram feed of specific user
  when userId is IgUser:
    let userId = userId.id
  when nextMaxId is IgFeed:
    let nextMaxId = nextMaxId.nextMaxId
  let json = await ig.get endpoint("feed/user/$#/?count=$#&max_id=$#", userId,
                                   limit, nextMaxId)
  result = json.fromJson IgFeed
