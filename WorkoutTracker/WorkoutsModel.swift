//
//  WorkoutsModel.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import Combine
import SwiftUI

/// Keeps a map of Calendar component .weekday values to the number of days to subtract to reach
/// the most recent Monday.
private let dayTranslation = [1: -6, 2: 0, 3: -1, 4: -2, 5: -3, 6: -4, 7: -5]

class WorkoutsModel: ObservableObject {
  @Published var workouts: [Workout] = []
  @Published var path: [WorkoutsPage.SubPages] = []
  @Published var selectedStartOfWeek: Date
  private var workoutSubscriptionHandles: Set<AnyCancellable> = []

  init() {
    let dayOfWeek = Calendar.current.component(.weekday, from: Date.now)
    selectedStartOfWeek = Calendar.current.date(
      byAdding: .day, value: dayTranslation[dayOfWeek]!, to: Date.now)!
    load()
  }

  func nextWeek() {
    selectedStartOfWeek = Calendar.current.date(
      byAdding: .day, value: 7, to: selectedStartOfWeek)!
    load()
  }

  func previousWeek() {
    selectedStartOfWeek = Calendar.current.date(
      byAdding: .day, value: -7, to: selectedStartOfWeek)!
    load()
  }

  private func load() {
    print("load(): \(selectedStartOfWeek)")
    // Cancel any prior subscriptions and remove prior handles.
    workoutSubscriptionHandles.forEach({ handle in handle.cancel() })
    workoutSubscriptionHandles.removeAll()

    client.subscribe(
      name: "workouts:getInRange",
      args: [
        "startDate": selectedStartOfWeek.localIso8601DateFormat(),
        "endDate": Calendar.current.date(byAdding: .day, value: 6, to: selectedStartOfWeek)!
          .localIso8601DateFormat(),
      ]
    )
    .replaceError(with: [])
    .receive(on: DispatchQueue.main)
    .assign(to: \.workouts, on: self)
    .store(in: &workoutSubscriptionHandles)
  }

  func openEditor() {
    path.append(.workoutEditor)
  }
}

extension Date {
  func localIso8601DateFormat() -> String {
    return self.ISO8601Format(.iso8601Date(timeZone: TimeZone.current))
  }
}
