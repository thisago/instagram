type
  # NilType* = ref object
  Followers* = ref object
    users*: seq[Users]
    bigList*: bool
    pageSize*: int64
    nextMaxId*: string
    hasMore*: bool
    shouldLimitListOfFollowers*: bool
    useClickableSeeMore*: bool
    status*: string
  Users* = ref object
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
    isPossibleBadActor*: IsPossibleBadActor
    shouldShowWarning*: bool
    latestReelMedia*: int64
  IsPossibleBadActor* = ref object
    isPossibleScammer*: bool
    isPossibleImpersonator*: IsPossibleImpersonator
    isPossibleImpersonatorThreads*: IsPossibleImpersonatorThreads
  IsPossibleImpersonator* = ref object
    isUnconnectedImpersonator*: bool
    # connectedSimilarUserId*: NilType
  IsPossibleImpersonatorThreads* = ref object
    isUnconnectedImpersonator*: bool
    # connectedSimilarUserId*: NilType
