//
//  WorkoutsPage.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import SwiftUI

struct WorkoutsPage: View {
  enum SubPages {
    case workoutEditor
  }

  @StateObject var workoutsModel = WorkoutsModel()

  var body: some View {
    NavigationStack(path: $workoutsModel.path) {
      VStack {
        Text("Start of week: \(workoutsModel.selectedStartOfWeek.localIso8601DateFormat())")
        HStack {
          Button(action: workoutsModel.previousWeek) { Text("Previous week") }
          Button(action: workoutsModel.nextWeek) { Text("Next week") }
        }
        List {
          ForEach(workoutsModel.workouts) { workout in
            Text("\(workout.activity.rawValue)")
          }
        }
        Button(action: workoutsModel.openEditor) {
          Text("Add Workout")
        }
      }.navigationDestination(
        for: SubPages.self,
        destination: { _ in
          WorkoutEditorPage()
        })
    }
  }
}
