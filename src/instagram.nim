import instagram/core except get
export core

# API
import instagram/api/users
export users

import instagram/api/media
export media

when isMainModule:
  import json
  import asyncdispatch
  const cookies = staticRead "../developmentcookies.txt"
  let ig = waitFor newInstagram cookies
  # let user = waitFor ig.user "olobocacador"
  # let user = waitFor ig.post "3140623659379585160"
  let followers = waitFor ig.followers "57011964897"

  echo pretty %*followers
  echo pretty %*waitFor ig.followers("57011964897", followers)
