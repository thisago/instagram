import instagram/core except get
export core

# API
import instagram/api/users
export users

when isMainModule:
  import asyncdispatch
  let ig = waitFor newInstagram()
  let user = waitFor ig.user "hak5gear"
  echo user.biography
