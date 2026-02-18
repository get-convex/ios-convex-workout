//
//  WorkoutTrackerApp.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import ConvexAuth0
import ConvexMobile
import SwiftUI

let client = ConvexClientWithAuth(
  deploymentUrl: ConvexEnv.deploymentUrl, authProvider: Auth0Provider())

@main
struct WorkoutTrackerApp: App {
  init() {
    initConvexLogging()
  }
  var body: some Scene {
    WindowGroup {
      LandingPage()
    }
  }
}
