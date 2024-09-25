//
//  WorkoutsPage.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import SwiftUI

/// Keeps a map of Calendar component .weekday values to the number of days to subtract to reach
/// the most recent Monday.
private let dayTranslation = [1: -6, 2: 0, 3: -1, 4: -2, 5: -3, 6: -4, 7: -5]

struct WorkoutsPage: View {
  enum SubPages {
    case workoutEditor
  }

  @State var selectedStartOfWeek: Date
  @State var workoutsModel = WorkoutsModel()

  init() {
    let dayOfWeek = Calendar.current.component(.weekday, from: Date.now)
    selectedStartOfWeek = Calendar.current.date(
      byAdding: .day, value: dayTranslation[dayOfWeek]!, to: Date.now)!
  }

  var body: some View {
    NavigationStack(path: $workoutsModel.path) {
      VStack {
        Text("Start of week: \(selectedStartOfWeek.localIso8601DateFormat())")
        HStack {
          Button(action: {
            selectedStartOfWeek = Calendar.current.date(
              byAdding: .day, value: -7, to: selectedStartOfWeek)!
          }) { Text("Previous week") }
          Button(action: {
            selectedStartOfWeek = Calendar.current.date(
              byAdding: .day, value: 7, to: selectedStartOfWeek)!
          }) { Text("Next week") }
        }
        List {
          ForEach(workoutsModel.workouts) { workout in
            Text("\(workout.activity.rawValue)")
          }
        }
        Button(action: workoutsModel.openEditor) {
          Text("Add Workout")
        }
      }.onAppear {
        workoutsModel.load(date: selectedStartOfWeek)
      }
      .onChange(
        of: selectedStartOfWeek,
        {
          workoutsModel.load(date: selectedStartOfWeek)
        }
      )
      .navigationDestination(
        for: SubPages.self,
        destination: { _ in
          WorkoutEditorPage()
        })
    }
  }
}
