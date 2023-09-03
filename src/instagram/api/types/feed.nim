type
  # IgFeedNilType* = ref object
  IgFeed* = ref object
    items*: seq[IgFeedItems]
    numResults*: int64
    moreAvailable*: bool
    nextMaxId*: string
    user*: IgFeedUser
    autoLoadMoreEnabled*: bool
    status*: string
    message*: string ## Error message
  IgFeedItems* = ref object
    takenAt*: int64
    pk*: string
    id*: string
    deviceTimestamp*: int64
    clientCacheKey*: string
    filterType*: int64
    captionIsEdited*: bool
    likeAndViewCountsDisabled*: bool
    isReshareOfTextPostAppMediaInIg*: bool
    isPostLiveClipsMedia*: bool
    deletedReason*: int64
    integrityReviewDecision*: string
    hasSharedToFb*: int64
    isUnifiedVideo*: bool
    shouldRequestAds*: bool
    isVisualReplyCommenterNoticeEnabled*: bool
    commercialityStatus*: string
    exploreHideComments*: bool
    usertags*: IgFeedUsertags
    photoOfYou*: bool
    # shopRoutingUserId*: IgFeedNilType
    canSeeInsightsAsBrand*: bool
    isOrganicProductTaggingEligible*: bool
    hasLiked*: bool
    likeCount*: int64
    # facepileTopLikers*: seq[IgFeedNilType]
    topLikers*: seq[string]
    mediaType*: int64
    code*: string
    canViewerReshare*: bool
    caption*: IgFeedCaption
    # clipsTabPinnedUserIds*: seq[IgFeedNilType]
    commentInformTreatment*: IgFeedCommentInformTreatment
    sharingFrictionInfo*: IgFeedSharingFrictionInfo
    originalMediaHasVisualReplyMedia*: bool
    coauthorProducers*: seq[IgFeedCoauthorProducers]
    canViewerSave*: bool
    isInProfileGrid*: bool
    profileGridControlEnabled*: bool
    # featuredProducts*: seq[IgFeedNilType]
    isCommentsGifComposerEnabled*: bool
    # productSuggestions*: seq[IgFeedNilType]
    user*: IgFeedUser
    imageVersions2*: IgFeedImageVersions2
    originalWidth*: int64
    originalHeight*: int64
    productType*: string
    isPaidPartnership*: bool
    musicMetadata*: IgFeedMusicMetadata
    organicTrackingToken*: string
    commerceIntegrityReviewDecision*: string
    igMediaSharingDisabled*: bool
    isOpenToPublicSubmission*: bool
    commentLikesEnabled*: bool
    commentThreadingEnabled*: bool
    maxNumVisiblePreviewComments*: int64
    hasMoreComments*: bool
    nextMaxId*: string
    previewComments*: seq[IgFeedPreviewComments]
    comments*: seq[IgFeedComments]
    commentCount*: int64
    canViewMorePreviewComments*: bool
    hideViewAllCommentEntrypoint*: bool
    inlineComposerDisplayCondition*: string
    carouselMediaCount*: int64
    carouselMedia*: seq[IgFeedCarouselMedia]
    carouselMediaIds*: seq[string]
    carouselMediaPendingPostCount*: int64
    hasDelayedMetadata*: bool
  IgFeedUsertags* = ref object
    `in`*: seq[IgFeedIn]
  IgFeedIn* = ref object
    user*: IgFeedUser
    position*: seq[float64]
    # startTimeInVideoInSec*: IgFeedNilType
    # durationInVideoInSec*: IgFeedNilType
  IgFeedCaption* = ref object
    pk*: string
    userId*: string
    user*: IgFeedUser
    `type`*: int64
    text*: string
    didReportAsSpam*: bool
    createdAt*: int64
    createdAtUtc*: int64
    contentType*: string
    status*: string
    bitFlags*: int64
    shareEnabled*: bool
    isRankedComment*: bool
    isCovered*: bool
    privateReplyStatus*: int64
    mediaId*: string
  IgFeedFanClubInfo* = ref object
    # fanClubId*: IgFeedNilType
    # fanClubName*: IgFeedNilType
    # isFanClubReferralEligible*: IgFeedNilType
    # fanConsiderationPageRevampEligiblity*: IgFeedNilType
    # isFanClubGiftingEligible*: IgFeedNilType
    # subscriberCount*: IgFeedNilType
    # connectedMemberCount*: IgFeedNilType
    # autosaveToExclusiveHighlight*: IgFeedNilType
    # hasEnoughSubscribersForSsc*: IgFeedNilType
      # fanClubId*: IgFeedNilType
  IgFeedHdProfilePicUrlInfo* = ref object
    url*: string
    width*: int64
    height*: int64
  IgFeedHdProfilePicVersions* = ref object
    width*: int64
    height*: int64
    url*: string
  IgFeedCommentInformTreatment* = ref object
    shouldHaveInformTreatment*: bool
    text*: string
    # url*: IgFeedNilType
    # actionType*: IgFeedNilType
  IgFeedSharingFrictionInfo* = ref object
    shouldHaveSharingFriction*: bool
    # bloksAppUrl*: IgFeedNilType
    # sharingFrictionPayload*: IgFeedNilType
  IgFeedCoauthorProducers* = ref object
    pk*: string
    pkId*: string
    fullName*: string
    isPrivate*: bool
    username*: string
    isVerified*: bool
    profilePicId*: string
    profilePicUrl*: string
    profileGridDisplayType*: string
  IgFeedImageVersions2* = ref object
    candidates*: seq[IgFeedCandidates]
  IgFeedCandidates* = ref object
    width*: int64
    height*: int64
    url*: string
    scansProfile*: string
  IgFeedMusicMetadata* = ref object
    musicCanonicalId*: string
    # audioType*: IgFeedNilType
    # musicInfo*: IgFeedNilType
    # originalSoundInfo*: IgFeedNilType
    # pinnedMediaIds*: IgFeedNilType
  IgFeedPreviewComments* = ref object
    hasLikedComment*: bool
    commentLikeCount*: int64
    pk*: string
    userId*: string
    user*: IgFeedUser
    `type`*: int64
    text*: string
    didReportAsSpam*: bool
    createdAt*: int64
    createdAtUtc*: int64
    contentType*: string
    status*: string
    bitFlags*: int64
    shareEnabled*: bool
    isRankedComment*: bool
    isCovered*: bool
    privateReplyStatus*: int64
    mediaId*: string
  IgFeedComments* = ref object
    hasLikedComment*: bool
    commentLikeCount*: int64
    pk*: string
    userId*: string
    user*: IgFeedUser
    `type`*: int64
    text*: string
    didReportAsSpam*: bool
    createdAt*: int64
    createdAtUtc*: int64
    contentType*: string
    status*: string
    bitFlags*: int64
    shareEnabled*: bool
    isRankedComment*: bool
    isCovered*: bool
    privateReplyStatus*: int64
    mediaId*: string
  IgFeedUser* = ref object
    pk*: string
    pkId*: string
    fullName*: string
    isPrivate*: bool
    fbidV2*: string
    username*: string
    isVerified*: bool
    profilePicId*: string
    profilePicUrl*: string
    isUnpublished*: bool
    id*: string
    feedPostReshareDisabled*: bool
    showAccountTransparencyDetails*: bool
    thirdPartyDownloadsEnabled*: int64
    hasAnonymousProfilePicture*: bool
    transparencyProductEnabled*: bool
    isFavorite*: bool
    # accountBadges*: seq[IgFeedNilType]
    latestReelMedia*: int64
    fanClubInfo*: IgFeedFanClubInfo
    hdProfilePicUrlInfo*: IgFeedHdProfilePicUrlInfo
    hdProfilePicVersions*: seq[IgFeedHdProfilePicVersions]
    profileGridDisplayType*: string
  IgFeedCarouselMedia* = ref object
    id*: string
    mediaType*: int64
    imageVersions2*: IgFeedImageVersions22
    originalWidth*: int64
    originalHeight*: int64
    explorePivotGrid*: bool
    accessibilityCaption*: string
    productType*: string
    carouselParentId*: string
    pk*: string
    commercialityStatus*: string
    usertags*: IgFeedUsertags
    # featuredProducts*: seq[IgFeedNilType]
    sharingFrictionInfo*: IgFeedSharingFrictionInfo2
    # productSuggestions*: seq[IgFeedNilType]
  IgFeedImageVersions22* = ref object
    candidates*: seq[IgFeedCandidates2]
  IgFeedCandidates2* = ref object
    width*: int64
    height*: int64
    url*: string
  IgFeedSharingFrictionInfo2* = ref object
    shouldHaveSharingFriction*: bool
    # bloksAppUrl*: IgFeedNilType
    # sharingFrictionPayload*: IgFeedNilType
