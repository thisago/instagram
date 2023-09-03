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

## TODO

- [ ] Get post comments
- [ ] Like a post
- [ ] (Un)Follow a user

## License

This library is licensed over MIT license!
