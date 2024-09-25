//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Christian Wyglendowski on 9/24/24.
//

import ConvexMobile

struct Workout: Identifiable, Decodable {
  let id: String
  let date: String
  let activity: Activity
  @OptionalConvexInt
  var duration: Int?

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case date
    case activity
    case duration
  }
}

enum Activity: String, Codable {
  case running = "Running"
  case lifting = "Lifting"
  case walking = "Walking"
  case swimming = "Swimming"
}
