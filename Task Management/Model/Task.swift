//
//  Task.swift
//  Task Management
//
//  Created by Mayur Vaity on 02/08/24.
//

import SwiftUI

struct Task: Identifiable {
    //.init() - creates a random id (unique)
    var id: UUID = .init()
    var taskTitle: String
    //.init() - Creates a date value initialized to the current date and time.
    var creationDate: Date = .init()
    var isCompleted = false
    var tint: Color
}

//sample tasks for preview 
var sampleTasks: [Task] = [
    .init(taskTitle: "Record Video", creationDate: .updateHour(-5), isCompleted: true, tint: .taskColor1),
    .init(taskTitle: "Redesign website", creationDate: .updateHour(-3), tint: .taskColor2),
    .init(taskTitle: "Go for a walk", creationDate: .updateHour(-4), tint: .taskColor3),
    .init(taskTitle: "Edit the Video", creationDate: .updateHour(0), isCompleted: true, tint: .taskColor4),
    .init(taskTitle: "Publish the Video", creationDate: .updateHour(2), isCompleted: true, tint: .taskColor1),
    .init(taskTitle: "Tweet about new Video", creationDate: .updateHour(1), tint: .taskColor5)
]

//ext to create fn which returns today's data by adding specified hours
extension Date {
    static func updateHour(_ value: Int) -> Date {
        //create a calendar obj
        let calendar = Calendar.current
        //using calendar obj, create a date by adding hour value (received as parameter) to current date
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
