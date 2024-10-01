//
//  WorkoutDetailPage.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import SwiftUI

struct WorkoutEditorPage: View {

  @StateObject var pendingWorkout = PendingWorkoutModel()
  @EnvironmentObject var navigationModel: NavigationModel

  var body: some View {
    VStack {
      List {
        DatePicker(
          "Date",
          selection: $pendingWorkout.date,
          displayedComponents: .date
        )
        Picker("Activity", selection: $pendingWorkout.activity) {
          if pendingWorkout.activity == nil {
            Text("No selection").tag(nil as Activity?)
          }
          ForEach(Array(Activity.allCases)) { activity in
            Text(activity.rawValue).tag(Optional(activity))
          }
        }
        TextField("Duration", text: $pendingWorkout.rawDuration).keyboardType(.decimalPad)
      }
      Button(action: { pendingWorkout.save(onSuccess: navigationModel.closeEditor) }) {
        Text("Save")
      }.disabled(!pendingWorkout.canSave)
    }.navigationTitle("New workout")
  }
}
