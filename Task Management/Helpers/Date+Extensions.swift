//
//  Date+Extensions.swift
//  Task Management
//
//  Created by Mayur Vaity on 02/08/24.
//

import Foundation

//Date extensions needed to build UI
extension Date {
    //Custom date format
    func format(_ format: String) -> String {
        //creating date formatter obj
        let formatter = DateFormatter()
        //assigning date format to the formatter obj
        formatter.dateFormat = format
        
        //converting date to string (as per formatter details) and returning it 
        return formatter.string(from: self)
    }
    
    //checking whether the date is today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    //Fetching week based on given date
    //getting a date as parameter to return days in that week,
    //if parameter is not passed will get today's date by default
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        //creating calendar obj
        let calendar = Calendar.current
        //return date with 12:00am time
        let startOfDate = calendar.startOfDay(for: date)
        
        //creating obj to store days of the week
        var week: [WeekDay] = []
        //to get start and end dates of the week (week selected based on date received as parameter)
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: date)
        //getting 1st day of the week, if any issue then return blank array
        guard let startOfWeek = weekForDate?.start else {
            return []
        }
        
        //iterating through week dates we got abv, to get each day
        (0..<7).forEach { index in
            //getting each day by adding days as per index (interator) to 1st day of the week
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                //appending calculated date to the week array
                week.append(.init(date: weekDay))
            }
        }
        
        //returing array full of days of the week 
        return week
    }
    
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
