import instagram/core except get, endpoint
export core

# Types
import instagram/types/api/user
export user except IgUserResponse
import instagram/types/api/followersAndFollowing
export followersAndFollowing
import instagram/types/api/post as postTypes
export postTypes
import instagram/types/api/feed
export feed
import instagram/types/xigSharedData
export xigSharedData

# API
import instagram/api/get
export get
import instagram/api/post
export post

proc hasNextPage*(obj: IgFollowersAndFollowing or IgFeed): bool =
  ## Check if exists next page
  obj.nextMaxId.len > 0
