# ios-convex-workout

Sample iOS Convex app using SwiftUI

New to Convex? [Take the tour](https://docs.convex.dev/get-started).

## Getting Started

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
