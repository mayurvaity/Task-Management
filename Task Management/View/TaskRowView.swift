//
//  TaskRowView.swift
//  Task Management
//
//  Created by Mayur Vaity on 04/08/24.
//

import SwiftUI
import SwiftData

struct TaskRowView: View {
    //binding var to keep task data and send back changes made here 
    @Bindable var task: Task
    
    //model context for interaction with swiftdata db
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            //status dot on left side
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle) //for circle around blue dot
                .overlay {
                    //adding bigger tappable area to tap on the small dot
                    Circle()
                        .foregroundStyle(.clear)
                        .contentShape(.circle) //alternate way to receive taps
                        .frame(width: 50, height: 50)
//                        .blendMode(.destinationOver) //to blend with the bg components
                        .onTapGesture {
                            //on tapping on this task to be set as completed
                            withAnimation(.snappy) {
                                task.isCompleted.toggle()
                            }
                        }
                }
            
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
            .background(task.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            //to cross off completed tasks
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            //contentShape - to specify how this vw will look when tap and hold is performed on a task
            //.rect(cornerRadius: 15) - 2nd parameter below, here we can specify shape of the vw
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            //tap on a task and hold, then below button will show
            .contextMenu {
                Button("Delete task", role: .destructive) {
                    //deleting task
                    //deleting from model context
                    context.delete(task)
                    //to save changes in db
                    try? context.save()
                }
            }
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
