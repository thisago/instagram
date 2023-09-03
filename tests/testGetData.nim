import std/asyncdispatch
import std/unittest

from std/random import randomize, rand
from std/strutils import contains

import instagram

randomize()

template humanize(body: untyped; minTaskTime = 1000; maxTaskTime = 0): untyped =
  var maxTaskT = maxTaskTime
  if maxTaskTime < minTaskTime:
    maxTaskT = minTaskTime * 2
  template delay: int =
    int(rand(minTaskTime..maxTaskT) / 2)
  waitFor sleepAsync delay
  body
  waitFor sleepAsync delay

const cookies = staticRead "../developmentcookies.txt"
let ig = waitFor newInstagram cookies
var user: IgUser

suite "Get Instagram data":
  test "User":
    humanize:
      user = waitFor ig.user "microsoft"
    require user.biography.len > 5
    require user.id == "524549267"
    require user.fullName == "Microsoft"
    require user.categoryEnum == "SCIENCE_ENGINEERING"
    require user.businessCategoryName == "Business & Utility Services"
  test "Post":
    let postId = user.edgeOwnerToTimelineMedia.edges[0].node.id
    humanize:
      let post = waitFor ig.post postId
    require post.status == "ok"
    require post.commentCount > 44
    require "Albert D." in post.caption.text
