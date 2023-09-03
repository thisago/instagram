<div align=center>

# Instagram

#### Instagram internal web api implementation

**[About](#about) - [Features](#features)** - [License](#license)

</div>

## About

This library is a implementation of internal Instagram web API.

With this library, you can get data and even interact with Instagram!

## Features

The following internal endpoints are implemented:

- **`ig.user("username")`** <sup>(`/api/v1/users/web_profile_info`)</sup>: Gets all info used to render the user page
- **`ig.post("postId")`** <sup>(`/api/v1/media/{postId}/comments`)</sup>: All data used to render the post
- **`ig.followers("userId")`** <sup>(`/api/v1/friendships/{userId}/followers`)</sup>: User followers
- **`ig.following("userId")`** <sup>(`/api/v1/friendships/{userId}/following`)</sup>: User following
- **`ig.feed("userId")`** <sup>(`/api/v1/feed/user/{userId}`)</sup>: Feed data, posts

\* **`Ig`** is a Instagram object

## Usage

> **Warning**
> This implementation violates the Instagram's terms of use, to prevent bans,
> call the API with random delays to looks like a human.

**Let's start with the usage guide**

### Getting data

To use the lib, you'll need a `Instagram` object instance, it stores your
authentication cookies, the CSRF cookie and extra IDs

To create one:

```nim
import std/asyncdispatch

let ig = waitFor newInstagram() # No cookies, there's rate limit
# or
let loggedIg = waitFor newInstagram "YOUR COOKIES" # With login
```

To get cookies, consider using [iecook](https://github.com/thisagp/iecook) because it gets the HttpOnly cookies, the needed ones. automatically.

**[...]**

## TODO

- [ ] Get post comments
- [ ] Like a post
- [ ] Comment in a post
- [ ] Add new post
- [ ] Add new status
- [ ] (Un)Follow a user

## License

This library is licensed over MIT license!
