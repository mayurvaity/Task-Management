//
//  TaskRowView.swift
//  Task Management
//
//  Created by Mayur Vaity on 04/08/24.
//

import SwiftUI

struct TaskRowView: View {
    //binding var to keep task data and send back changes made here 
    @Binding var task: Task
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            //status dot on left side
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle) //for circle around blue dot
            
            //for task title and time
            VStack(alignment: .leading, spacing: 8) {
                //task title
                Text(task.taskTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                //task time
                Label(task.creationDate.format("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.black)
            }
            .padding(15)
            .hSpacing(.leading)
            //to give bg color to the tasks as per their status, also applying corner radius
            .background(task.tint, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            //to cross off completed tasks
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            //to move this vstack a little up 
            .offset(y: -8)
            
        }
        .hSpacing(.leading) //to keep everything within vw aligned to the left
    }
    
    //to set color of the status dot of tasks
    var indicatorColor: Color {
        //if task is completed return green else darkblue 
        if task.isCompleted {
            return .green
        }
        
        //checking if task time matches current time (by hr) then assigning color darkBlue
        //if task is past due then assigning color red
        //if task is pending in future hr then assigning color black
        return task.creationDate.isSameHour ? .darkBlue : (task.creationDate.isPast ? .red : .black)
    }
}

#Preview {
    ContentView()
}
