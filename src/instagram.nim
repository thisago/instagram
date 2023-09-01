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
  let ig = waitFor newInstagram()
  # let user = waitFor ig.user "microsoft"
  let user = waitFor ig.post "3140623659379585160"
  
  echo pretty %*user
