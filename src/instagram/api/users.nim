import std/asyncdispatch

import pkg/jsony

import instagram/core
import instagram/api/types/user

proc user*(ig: Instagram; username: string): Future[User] {.async.} =
  ## Gets instagram user from their internal API
  let
    json = await ig.get endpoint("users/web_profile_info/?username=$#", username)
    resp = json.fromJson Response
  
  result = resp.data.user
