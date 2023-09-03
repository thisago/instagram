type
  # NilType* = ref object
  IgFollowers* = ref object
    users*: seq[IgFollowersUsers]
    bigList*: bool
    pageSize*: int64
    nextMaxId*: string
    hasMore*: bool
    shouldLimitListOfFollowers*: bool
    useClickableSeeMore*: bool
    status*: string
    message*: string ## Error message
  IgFollowersUsers* = ref object
    fbidV2*: string
    pk*: string
    pkId*: string
    fullName*: string
    isPrivate*: bool
    thirdPartyDownloadsEnabled*: int64
    hasAnonymousProfilePicture*: bool
    username*: string
    isVerified*: bool
    profilePicId*: string
    profilePicUrl*: string
    # accountBadges*: seq[NilType]
    isPossibleScammer*: bool
    isPossibleBadActor*: IgFollowersIsPossibleBadActor
    shouldShowWarning*: bool
    latestReelMedia*: int64
  IgFollowersIsPossibleBadActor* = ref object
    isPossibleScammer*: bool
    isPossibleImpersonator*: IgFollowersIsPossibleImpersonator
    isPossibleImpersonatorThreads*: IgFollowersIsPossibleImpersonatorThreads
  IgFollowersIsPossibleImpersonator* = ref object
    isUnconnectedImpersonator*: bool
    # connectedSimilarUserId*: NilType
  IgFollowersIsPossibleImpersonatorThreads* = ref object
    isUnconnectedImpersonator*: bool
    # connectedSimilarUserId*: NilType
