import std/asyncdispatch

import pkg/jsony

import instagram/core
import instagram/api/types/post

proc post*(ig: Instagram; postId: string): Future[Post] {.async.} =
  ## Gets instagram user from their internal API
  let json = await ig.get endpoint("media/$#/comments/?can_support_threading=true&permalink_enabled=false", postId)
  result = json.fromJson Post
