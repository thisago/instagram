import std/asyncdispatch

import pkg/jsony

import instagram/core
import instagram/api/types/user
import instagram/api/types/followers

proc user*(ig: Instagram; username: string): Future[User] {.async.} =
  ## Gets instagram user from their internal API
  let
    json = await ig.get endpoint("users/web_profile_info/?username=$#", username)
    resp = json.fromJson Response
  result = resp.data.user

proc followers*(
  ig: Instagram;
  userId: string or User; ## User ID or User
  maxId: string or Followers = ""; ## Next max ID or Followers
  limit = 12
): Future[Followers] {.async.} =
  ## Gets the user followers
  when userId is User:
    let userId = userId.id
  when maxId is Followers:
    let maxId = maxId.nextMaxId

  let json = await ig.get endpoint("friendships/$#/followers/?count=$#&max_id=$#&search_surface=follow_list_page",
                                   userId, $limit,
                                   if maxId.len > 0: maxId else: $limit)
  result = json.fromJson Followers
