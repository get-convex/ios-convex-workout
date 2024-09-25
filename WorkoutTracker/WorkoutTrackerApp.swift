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
  deploymentUrl: ConvexEnv.deploymentUrl, authProvider: Auth0Provider(enableCachedLogins: true))

@main
struct WorkoutTrackerApp: App {
  var body: some Scene {
    WindowGroup {
      LandingPage()
    }
  }
}
