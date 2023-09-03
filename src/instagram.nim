import instagram/core except get, endpoint
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
  # let user = waitFor ig.user "microsoft"
  let user = waitFor ig.post "3182352174481337412"
  # let followers = waitFor ig.followers "57011964897"

  echo pretty %*user
  # echo pretty %*followers
  # echo pretty %*waitFor ig.followers("57011964897", followers)
