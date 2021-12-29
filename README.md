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
