import instagram/core except get, endpoint
export core

# API
import instagram/api/get
export get
import instagram/api/post
export post

proc hasNextPage*(obj: IgFollowersAndFollowing or IgFeed): bool =
  ## Check if exists next page
  obj.nextMaxId.len > 0
