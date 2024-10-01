//
//  WorkoutsPage.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import SwiftUI

extension Day {
  var firstLetter: String {
    guard let firstLetter = "\(self)".uppercased().first else {
      fatalError()
    }
    return "\(firstLetter)"
  }
}

private var abbrevDateFormatter: DateFormatter {
  let dateFormatter = DateFormatter()
  dateFormatter.setLocalizedDateFormatFromTemplate("MMM d")
  dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
  return dateFormatter
}

struct WorkoutsPage: View {
  enum SubPages {
    case workoutEditor
  }

  @StateObject var workoutsModel = WorkoutsModel()

  var body: some View {
    NavigationStack(path: $workoutsModel.path) {
      VStack {
        WorkoutDateSelector()
        WorkoutCalendar()
        WorkoutList()
        Button(action: workoutsModel.openEditor) {
          Text("Add Workout")
        }
      }.navigationDestination(
        for: SubPages.self,
        destination: { _ in
          WorkoutEditorPage()
        }
      )
      .navigationTitle("Workouts")
    }.environmentObject(workoutsModel)
  }
}

struct WorkoutDateSelector: View {
  @EnvironmentObject var workoutsModel: WorkoutsModel

  var body: some View {
    HStack {
      Spacer()
      Button(action: workoutsModel.previousWeek) {
        Image(systemName: "arrowshape.backward")
      }
      Spacer()
      Text(
        "Week of \(workoutsModel.selectedStartOfWeek.formatted(date: .abbreviated, time: .omitted))"
      )
      Spacer()
      Button(action: workoutsModel.nextWeek) {
        Image(systemName: "arrowshape.forward")
      }
      Spacer()
    }
  }
}

struct WorkoutCalendar: View {
  @EnvironmentObject var workoutsModel: WorkoutsModel

  var body: some View {
    HStack {
      ForEach(Array(Day.allCases)) { day in
        Spacer()
        VStack {
          Text(day.firstLetter)
          if workoutsModel.workoutDays.contains(day) {
            Image(systemName: "circle.inset.filled")
          } else {
            Image(systemName: "circle.dotted")
          }
        }
      }
      Spacer()
    }
  }
}

struct WorkoutList: View {
  @EnvironmentObject var workoutsModel: WorkoutsModel

  var body: some View {
    List {
      ForEach(workoutsModel.workouts) { workout in
        VStack(alignment: .leading) {
          Text(abbrevDateFormatter.string(from: workout.date))
          HStack {
            Text("\(workout.activity.rawValue)")
            Spacer()
            if let duration = workout.duration {
              Text("\(duration) min\(duration > 1 ? "s" : "")")
            }
          }
        }
      }
    }
  }
}
