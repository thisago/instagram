import instagram/core except get, endpoint
export core

# Types
import instagram/api/types/user
export user except IgUserResponse
import instagram/api/types/followersAndFollowing
export followersAndFollowing
import instagram/api/types/post
export post
import instagram/api/types/feed
export feed

# API
import instagram/api/get
export get
import instagram/api/post
export post

proc hasNextPage*(obj: IgFollowersAndFollowing or IgFeed): bool =
  ## Check if exists next page
  obj.nextMaxId.len > 0
