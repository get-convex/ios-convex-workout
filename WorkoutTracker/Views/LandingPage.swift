//
//  LandingPage.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import SwiftUI

struct LandingPage: View {
  @State var authModel = AuthModel()

  var body: some View {
    Group {
      switch authModel.authState {
      case .loading:
        ProgressView()
      case .unauthenticated:
        VStack {
          Text("Workout Tracker")
            .font(.largeTitle)
          Button(action: authModel.login) {
            Text("Login")
              .font(.title)
          }

        }
        .padding()
      case .authenticated(_):
        WorkoutsPage()
      }
    }
  }
}

#Preview {
  LandingPage()
}
