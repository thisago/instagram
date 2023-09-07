<div align=center>

# Instagram

#### Instagram internal web api implementation

**[About](#about) - [Features](#features)** - [License](#license)

</div>

## About

This library is a implementation of internal Instagram web API.

With this library, you can get data and even interact with Instagram!

## Features

- **`ig.sharedData`**: Logged account data

The following internal endpoints are implemented:

### GET

- **`ig.user("username")`** <sup>(`/api/v1/users/web_profile_info`)</sup>: Gets all info used to render the user page
- **`ig.post("postId")`** <sup>(`/api/v1/media/{postId}/comments`)</sup>: All data used to render the post
- **`ig.followers("userId")`** <sup>(`/api/v1/friendships/{userId}/followers`)</sup>: User followers
- **`ig.following("userId")`** <sup>(`/api/v1/friendships/{userId}/following`)</sup>: User following
- **`ig.feed("userId")`** <sup>(`/api/v1/feed/user/{userId}`)</sup>: Feed data, posts

### POST

- **`ig.follow("userId")`** <sup>(`/api/v1/friendships/create/{userId}`)</sup>: Follows the user
- **`ig.unfollow("userId")`** <sup>(`/api/v1/friendships/destroy/{userId}`)</sup>: Unfollows the user
- **`ig.like("userId")`** <sup>(`/api/v1/web/likes/{postId}/like`)</sup>: Likes the post
- **`ig.unlike("userId")`** <sup>(`/api/v1/web/likes/{postId}/unlike`)</sup>: Remove the like of post

\* **`Ig`** is a `Instagram` object

## Usage

> **Warning**
> This implementation may violate the Instagram's terms of use, to prevent bans,
> call the API with random delays to looks like a human.

**Let's start with the usage guide**

### Getting data

To use the lib, you'll need a `Instagram` object instance, it stores your
authentication cookies, the CSRF cookie and extra IDs

To create one:

```nim
import std/asyncdispatch

let ig = waitFor newInstagram() # No cookies, there's rate limit and limited just to GET functions
# or
let loggedIg = waitFor newInstagram "YOUR COOKIES" # With login
```

To get cookies, consider using [iecook](https://github.com/thisago/iecook) because it gets the HttpOnly cookies, the needed ones. automatically.

**[...]**

## TODO

- Get post comments
- Comment in a post
- Add new post
- Add new status
- Get your following state of a user
- `follow` and `unfollow` needs to return the response object

## Resources

- https://instagram.api-docs.io

### Related

- https://github.com/pavlovdog/Instagram-private-API/blob/master/api.py
- https://github.com/dilame/instagram-private-api
- https://github.com/ping/instagram_private_api

## License

This library is licensed over MIT license!
