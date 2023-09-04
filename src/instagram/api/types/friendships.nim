from std/tables import Table

type
  IgFriendshipStatusResponse* = ref object
    friendshipStatus*: IgFriendshipStatus
    previousFollowing*: bool
    status*: string
  IgFriendshipStatusesResponse* = ref object
    friendshipStatuses*: IgFriendshipStatuses
    status*: string
  IgFriendshipStatuses* = Table[string, IgFriendshipStatus]
  IgFriendshipStatus* = ref object
    following*: bool
    incomingRequest*: bool
    isBestie*: bool
    isPrivate*: bool
    isRestricted*: bool
    outgoingRequest*: bool
    isFeedFavorite*: bool
    followedBy*: bool
    blocking*: bool
    muting*: bool
    subscribed*: bool
    isEligibleToSubscribe*: bool
