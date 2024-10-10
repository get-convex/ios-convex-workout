# ios-convex-workout

Sample iOS Convex app using SwiftUI

New to Convex? [Take the tour](https://docs.convex.dev/get-started).

## Getting Started

1. Clone this repository
2. Run `npm i convex` to install Convex.
3. Create (or get access to) an
   [Auth0 application configuration](https://auth0.com/docs/quickstart/native/ios-swift)
   for a native iOS app.
4. On the Auth0 Settings page for your application, the callback and logout URLs should be set to:

```
https://{yourAuth0Domain}/ios/dev.convex.WorkoutTracker/callback,
dev.convex.WorkoutTracker://{yourAuth0Domain}/ios/dev.convex.WorkoutTracker/callback
```

5. Make sure your Auth0 Application Type setting is set to "Native".
6. Run `npx convex dev` and setup a new Convex application (or connect to an existing one for
   Workout Tracker) for the required backend functionality.
7. [Setup the environment variables](https://docs.convex.dev/auth/auth0#configuring-dev-and-prod-tenants)
   on the Convex backend: `AUTH0_CLIENT_ID` and `AUTH0_DOMAIN`
8. Follow the local app configuration instructions below.

## Configuration

1. Add a `ConvexEnv.swift` file in `WorkoutTracker/` with contents like:
```swift
struct ConvexEnv {
  static let deploymentUrl = "YOUR_CONVEX_DEPLOYMENT_URL"
}
```
2. Create an `Auth0.plist` file in `WorkoutTracker/` with contents like:
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Domain</key>
  <string>YOUR_AUTH0_DOMAIN</string>
  <key>ClientId</key>
  <string>YOUR_AUTH0_CLIENT_ID</string>
</dict>
</plist>
```
3. Make sure you substitute your real Convex and Auth0 values in the files above!

## Tools used

* [Public domain icon](https://www.svgrepo.com/svg/109426/gym-near)
* [Auth0](https://auth0.com/) for iOS Login
* [Convex](https://convex.dev) for app backend
