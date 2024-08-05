//
//  TasksView.swift
//  Task Management
//
//  Created by Mayur Vaity on 05/08/24.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @Binding var currentDate: Date
    
    //swiftdata dynamic query
    //to get all the data from swiftdata db
    @Query private var tasks: [Task]
    
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        
        ///predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue) //selected date with 12am timing
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate) //next day's date with 12am timing
        
        let predicate = #Predicate<Task> {
            //predicate to filter abv fetched tasks data based on following condition
            //blw condition to check if task creation date lies between the day of selected date
            //wrappedValue - to get value out of a binding var
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate!
        }
        
        ///Sorting (based on creation date i.e., task date)
        let sortDescriptor = [
            SortDescriptor(\Task.creationDate, order: .reverse)
        ]
        
        ///performing filtering (using predicate) and sorting (using sortDescriptor) on tasks data
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            ForEach(tasks) { task in
                //calling task row vw for each task (as a row)
                TaskRowView(task: task)
                    .background(alignment: .leading) {
                        //except for last task in the list, adding line below dot, that's why checking if this task is the last or not
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1) //making this rectangle of width 2
                                .offset(x: 8) //to adjust this line (rect) to right
                                .padding(.bottom, -35) //to extnd this below
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
    }
}

#Preview {
    ContentView()
}
