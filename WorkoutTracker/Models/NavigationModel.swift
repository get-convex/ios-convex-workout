//
//  NavigationModel.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 10/1/24.
//

import Foundation

class NavigationModel: ObservableObject {
  @Published var path: [WorkoutsPage.SubPages] = []

  func openEditor() {
    path.append(.workoutEditor)
  }

  func closeEditor() {
    path.removeAll()
  }
}
