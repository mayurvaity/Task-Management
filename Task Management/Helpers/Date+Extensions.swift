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
    
    //checking if the date is same hour
    var isSameHour: Bool {
        //orderedSame - to check if both values are matching
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    //checking if the date is past hour
    var isPast: Bool {
        //orderedAscending - to check if this value is less than 2nd value (i.e., current time) from the op of compare fn 
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
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
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
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
    
    //creating next week, based on the last date of the current week
    func createNextWeek() -> [WeekDay] {
        //creating a calendar obj
        let calendar = Calendar.current
        //getting start of lastdate (date w/ 12am time)
        let startOfLastDate = calendar.startOfDay(for: self)
        //getting 1st date of next week by adding 1 day to lastdate of this week
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        
        //getting next week's data by calling fetchWeek fn using 1st date of the week
        return fetchWeek(nextDate)
    }
    
    //creating previous week, based on the 1st date of the current week
    func createPreviousWeek() -> [WeekDay] {
        //creating a calendar obj
        let calendar = Calendar.current
        //getting start of firstdate (date w/ 12am time)
        let startOfFirstDate = calendar.startOfDay(for: self)
        //getting last date of previous week by deducting 1 day from firstdate of this week
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else {
            return []
        }
        
        //getting next week's data by calling fetchWeek fn using 1st date of the week
        return fetchWeek(previousDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
