//
//  WorkoutsModel.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import Combine
import SwiftUI

@Observable
class WorkoutsModel {
  var workouts: [Workout] = []
  private var workoutSubscriptionHandles: Set<AnyCancellable> = []

  func load(date: Date) {
    // Cancel any prior subscriptions and remove prior handles.
    workoutSubscriptionHandles.forEach({ handle in handle.cancel() })
    workoutSubscriptionHandles.removeAll()

    client.subscribe(
      name: "workouts:getInRange",
      args: [
        "startDate": date.localIso8601DateFormat(),
        "endDate": Calendar.current.date(byAdding: .day, value: 6, to: date)!
          .localIso8601DateFormat(),
      ]
    )
    .replaceError(with: [])
    .receive(on: DispatchQueue.main)
    .assign(to: \.workouts, on: self)
    .store(in: &workoutSubscriptionHandles)
  }
}

extension Date {
  func localIso8601DateFormat() -> String {
    return self.ISO8601Format(.iso8601Date(timeZone: TimeZone.current))
  }
}
