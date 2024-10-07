//
//  AuthModel.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import Auth0
import Combine
import ConvexMobile
import SwiftUI

class AuthModel: ObservableObject {
  @Published var authState: AuthState<Credentials> = .loading
  private var cancellationHandle: Set<AnyCancellable> = []

  init() {
    client.authState.replaceError(with: .unauthenticated)
      .receive(on: DispatchQueue.main)
      .assign(to: &$authState)
    Task {
      await client.loginFromCache()
    }
  }

  func login() {
    Task {
      await client.login()
    }
  }
}
