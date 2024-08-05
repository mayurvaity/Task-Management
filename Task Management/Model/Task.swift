//
//  Task.swift
//  Task Management
//
//  Created by Mayur Vaity on 02/08/24.
//


import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    
    var id: UUID
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool 
    var tint: String
    
    //.init() - creates a random id (unique) for id
    //.init() - Creates a date value initialized to the current date and time. for creationDate
    init(id: UUID = .init(), taskTitle: String, creationDate: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
        case "TaskColor1": return .taskColor1
        case "TaskColor2": return .taskColor2
        case "TaskColor3": return .taskColor3
        case "TaskColor4": return .taskColor4
        case "TaskColor5": return .taskColor5
        default: return .black 
        }
    }
}



//ext to create fn which returns today's data by adding specified hours
extension Date {
    static func updateHour(_ value: Int) -> Date {
        //create a calendar obj
        let calendar = Calendar.current
        //using calendar obj, create a date by adding hour value (received as parameter) to current date
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
