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

enum Day: CaseIterable, Identifiable {
  var id: Self {
    self
  }

  case monday
  case tuesday
  case wednesday
  case thursday
  case friday
  case saturday
  case sunday
}

class WorkoutsModel: ObservableObject {
  @Published var workouts: [Workout] = []
  @Published var path: [WorkoutsPage.SubPages] = []
  @Published var selectedStartOfWeek: Date
  @Published var workoutDays: Set<Day> = []

  init() {
    let dayOfWeek = Calendar.current.component(.weekday, from: Date.now)
    selectedStartOfWeek = Calendar.current.date(
      byAdding: .day, value: dayTranslation[dayOfWeek]!, to: Date.now)!
    $selectedStartOfWeek
      .print("week")
      .map({ week in
        client.subscribe(
          name: "workouts:getInRange",
          args: [
            "startDate": week.localIso8601DateFormat(),
            "endDate": Calendar.current.date(byAdding: .day, value: 6, to: week)!
              .localIso8601DateFormat(),
          ]
        )
        .print("subscription: \(week)")
        .replaceError(with: [])
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
      }).switchToLatest().assign(to: &$workouts)

    $workouts
      .map { weekWorkouts in
        Set(
          weekWorkouts.map { workout in
            workout.day
          })
      }.assign(to: &$workoutDays)
  }

  func nextWeek() {
    selectedStartOfWeek = Calendar.current.date(
      byAdding: .day, value: 7, to: selectedStartOfWeek)!
  }

  func previousWeek() {
    selectedStartOfWeek = Calendar.current.date(
      byAdding: .day, value: -7, to: selectedStartOfWeek)!
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

extension Workout {
  var day: Day {
    Calendar.current.component(.weekday, from: self.date).toDay()
  }
}

extension Int {
  internal func toDay() -> Day {
    switch self {
    case 1: Day.sunday
    case 2: Day.monday
    case 3: Day.tuesday
    case 4: Day.wednesday
    case 5: Day.thursday
    case 6: Day.friday
    case 7: Day.saturday
    default:
      fatalError()
    }
  }
}
