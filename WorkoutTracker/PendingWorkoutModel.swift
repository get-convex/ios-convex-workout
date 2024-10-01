//
//  PendingWorkoutModel.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 10/1/24.
//

import Combine
import ConvexMobile
import Foundation

class PendingWorkoutModel: ObservableObject {
  @Published var date: Date = Date()
  @Published var activity: Activity?
  @Published var rawDuration = ""
  @Published var canSave: Bool = false

  init() {
    $activity.map { activity in activity != nil }
      .assign(to: &$canSave)
  }

  func save() {
    let duration: Int? =
      switch rawDuration.trimmingCharacters(in: .whitespacesAndNewlines) {
      case "": nil
      case let val: Int(val)
      }
    var args =
      ["date": date.localIso8601DateFormat(), "activity": activity!.rawValue]
      as [String: ConvexEncodable]
    if duration != nil {
      args["duration"] = duration
    }
    Task {
      try await client.mutation(name: "workouts:store", args: args)
    }
  }
}
