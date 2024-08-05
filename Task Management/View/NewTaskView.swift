//
//  NewTaskView.swift
//  Task Management
//
//  Created by Mayur Vaity on 05/08/24.
//

import SwiftUI

struct NewTaskView: View {
    ///view properties
    //env var to dismiss sheet
    @Environment(\.dismiss) private var dismiss
    
    //vars to store user input like task title, task date and task color
    @State private var taskTitle = ""
    @State private var taskDate: Date = .init()
    @State private var taskColor: Color = .taskColor1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            //dismiss button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            })
            .hSpacing(.leading) //to make it align left
            
            //to receive text title input
            VStack(alignment: .leading, spacing: 8) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("Go for a walk!", text: $taskTitle)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
            }
            .padding(.top, 5)
            
            HStack(spacing: 12) {
                //to pick task date
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading) //to make this vw smaller
                }
                .padding(.top, 5)
                .padding(.trailing, -15)
                
                //to pick task color
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task Color")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    //creating array of colors to use in the below picker
                    let colors: [Color] = [.taskColor1, .taskColor2, .taskColor3, .taskColor4, .taskColor5]
                    
                    HStack(spacing: 0) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 20, height: 20)
                                .background {
                                    //to highlight (by adding border like around color circle) selected color
                                    Circle()
                                        .stroke(lineWidth: 2) //to draw circle around color circle
                                        .opacity(taskColor == color ? 1 : 0) //to show abv circle only if selected color matches with this color
                                }
                                .hSpacing(.center)
                                .contentShape(.rect) //to make tappable area square (bigger than circle)
                                .onTapGesture {
                                    //on tapping on one of the color, getting selected color in our var
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                }
                        }
                    }
                }
                
            }
            .padding(.top, 5)
            
            Spacer(minLength: 0)
            
            //create task button
            Button(action: {}, label: {
                Text("Create Task")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(taskColor, in: .rect(cornerRadius: 10))
                
            })
            .disabled(taskTitle == "") //to disable the button if task title field in empty
            .opacity(taskTitle == "" ? 0.5 : 1) //to fade the button if task title field in empty
        }
        .padding(15)
    }
}

#Preview {
    NewTaskView()
        .vSpacing(.bottom)
}
