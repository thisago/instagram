# Changelog

## Version 0.8.0 (2023/09/07)

- Added support to like feed items
- Renamed `IgFeedItems` to `IgFeedItem`
- Added `unifetch` dependency as url until it are't in Nimble
- Uncommented tests

## Version 0.7.0 (2023/09/07)

- Added `isLogged` to `Instagram` objects

## Version 0.6.0 (2023/09/07)

- Added `XIGSharedData` parsing to get logged used info
- Better HTTP headers
- Moved `instagram/api/types/*.nim` to `instagram/types/api/*.nim`

## Version 0.5.1 (2023/09/05)

- Fixed unfollow

## Version 0.5.0 (2023/09/05)

- Added logged user id extraction from cookie

## Version 0.4.2 (2023/09/04)

- Added `igDebugReqFile` config to set the output file to all requests made. Example: `-d:igDebugReqFile=out.json`
- Fixed get user following
- Other fixes

## Version 0.4.1 (2023/09/04)

- Fixed error raised when user needs to aprove the request

## Version 0.4.0 (2023/09/04)

- Added `friendships` POST action to get your relationship with user
- Added "Content-Type" just when POST
- Fixed more types accepted functions

## Version 0.3.0 (2023/09/04)

- Added first POST actions!
  - Added `follow` action
  - Added `unfollow` action!
  - Added `like` action
  - Added `unlike` action

## Version 0.2.0 (2023/09/03)

- Fixed user type
- Added followers endpoint; Now you can request the user followers by pages
- Added tests for user and post endpoints
- Renamed all types
- Added tests for followers
- Improved tests
- Moved all data getting API endpoints to a single file
- Cleaning
- Added CSRF token bypass!
- Added `following` extraction
- Added post request support
- Added CSRF token in cookies too
- Added exception raising

## Version 0.1.0 (2023/09/01)

- Init
- Added core
- Added user types
- Added user API endpoint
- Fixed user types
- Added media API endpoint
