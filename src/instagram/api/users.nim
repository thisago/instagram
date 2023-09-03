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

proc followers*(
  ig: Instagram;
  userId: string or IgUser; ## User ID or User
  maxId: string or IgFollowers = ""; ## Next max ID or Followers
  limit = 12
): Future[IgFollowers] {.async.} =
  ## Gets the user followers
  when userId is IgUser:
    let userId = userId.id
  when maxId is IgFollowers:
    let maxId = maxId.nextMaxId

  let json = await ig.get endpoint("friendships/$#/followers/?count=$#&max_id=$#&search_surface=follow_list_page",
                                   userId, $limit,
                                   if maxId.len > 0: maxId else: $limit)
  result = json.fromJson IgFollowers
