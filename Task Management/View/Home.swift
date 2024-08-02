//
//  Home.swift
//  Task Management
//
//  Created by Mayur Vaity on 02/08/24.
//

import SwiftUI

struct Home: View {
    // Task Manager Properties
    //keeping current date in a var
    @State private var currentDate: Date = .init()
    //??
    @State private var weekSlider: [] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
        }
        .vSpacing(.top) //to bring this vw to the top
    }
    
    // Header view
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            //for month and year
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.darkBlue)
                
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            //for date
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
            
            //Week Slider
            
            
        }
        .hSpacing(.leading) // to add spacing after (on right) abv vstack and to push this vw to the leading edge
        .overlay(alignment: .topTrailing, content: {
            Button(action: {}) {
                Image(.pic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(.circle)
            }
        })
        .padding(15)
        .background(.white)
    }
}

#Preview {
    ContentView()
}
