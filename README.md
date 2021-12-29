# HangBuddy

Your buddy for hangboarding

## Up & Running

### Mock API
For the search page to work, we need a JSON server running.  We have a basic, mocked API available via [`json-server`](https://www.npmjs.com/package/json-server).

Install `json-server` with:
```shell
$ npm i -g json-server
```

Run this (in the root of this project) with:
```shell
$ json-server --watch api.json --host '0.0.0.0'
```

## Next Steps

A short list of possible things that can be taken on now:
- [ ] Implement local (on-device) storage of "my routines"
- [ ] Add services for fetching routines from both local storage and API (so the code doesn't exist in the page)
- [ ] Fill out the `RoutineDetailPage`.  This should probably just contain some basic details about the routine and a start button (maybe an edit button??).
- [ ] Add ability to save routine from API to my routines
