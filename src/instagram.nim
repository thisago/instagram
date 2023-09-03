import instagram/core except get, endpoint
export core

# API
import instagram/api/get
export get

proc hasNextPage*(obj: IgFollowersAndFollowing or IgFeed): bool =
  ## Check if exists next page
  obj.nextMaxId.len > 0
