import std/asyncdispatch
import std/unittest

from std/random import randomize, rand
from std/strutils import contains

import instagram

randomize()

template humanize(body: untyped; minTaskTime = 1500; maxTaskTime = 0): untyped =
  var maxTaskT = maxTaskTime
  if maxTaskTime < minTaskTime:
    maxTaskT = minTaskTime * 2
  template delay: int = int(rand(minTaskTime..maxTaskT) / 2)
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

  test "Followers":
    proc testFollowers(uid: string; last: IgFollowersAndFollowing = nil): IgFollowersAndFollowing =
      humanize:
        if last.isNil:
          result = waitFor ig.followers uid
        elif last.hasNextPage:
          result = waitFor ig.followers(uid, last)
      require result.status == "ok"
      for follower in result.users:
        require follower.username.len > 0

    require not user.id.testFollowers.hasNextPage
    let fllwrs = testFollowers "188008629"
    require fllwrs.hasNextPage
    require "188008629".testFollowers(fllwrs).users[0].username != fllwrs.users[0].username

  test "Following":
    proc testFollowing(uid: string; last: IgFollowersAndFollowing = nil): IgFollowersAndFollowing =
      humanize:
        if last.isNil:
          result = waitFor ig.following uid
        elif last.hasNextPage:
          result = waitFor ig.following(uid, last)
      require result.status == "ok"
      for follower in result.users:
        require follower.username.len > 0

    let fllwrs = user.id.testFollowing
    require fllwrs.hasNextPage
    require "188008629".testFollowing(fllwrs).users[0].username != fllwrs.users[0].username

  test "Following Again":
    humanize:
      let fllwrs = waitFor ig.following "44988800462"

    require fllwrs.users.len == 9

  test "Feed":
    proc testFeed(uid: IgUser; last: IgFeed = nil): IgFeed =
      humanize:
        if last.isNil:
          result = waitFor ig.feed uid
        elif last.hasNextPage:
          result = waitFor ig.feed(uid, last)
      require result.status == "ok"
      for post in result.items:
        require post.caption.text.len > 0
    let fd = user.testFeed
    require fd.hasNextPage
    require user.testFeed(fd).items[0].caption.text != fd.items[0].caption.text
