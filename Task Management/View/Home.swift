//
//  Home.swift
//  Task Management
//
//  Created by Mayur Vaity on 02/08/24.
//

import SwiftUI

struct Home: View {
    // Task Manager Properties
    //keeping current date in a var (var also used for selected date)
    @State private var currentDate: Date = .init()
    //var containing arrays of week dates for week slider
    @State private var weekSlider: [[Date.WeekDay]] = []
    //index of selected week array from weekslider array
    @State private var currentWeekIndex: Int = 1
    //to manage createweek action 
    @State private var createWeek: Bool = false
    
    //animation namespace
    @Namespace private var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
        }
        .vSpacing(.top) //to bring this vw to the top
        .onAppear {
            //if there is no weekSlider data available
            if weekSlider.isEmpty {
                //getting current week dates data
                let currentWeek = Date().fetchWeek()
                
                //getting 1st date of the current week
                if let firstDate = currentWeek.first?.date {
                    //getting last week's data using 1st date and appending it to the weekslider array
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                //appending current week dates data to weekslider data
                weekSlider.append(currentWeek)
                
                //getting last date of the current week
                if let lastDate = currentWeek.last?.date {
                    //getting next week's data using last date and appending it to the weekslider array
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
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
            //TabView - to show week slider with 7 dates
            TabView(selection: $currentWeekIndex) {
                //getting weeks dates using weekSlider and looping for each week
                ForEach(weekSlider.indices, id: \.self) { index in
                    //var to keep a single week's data
                    let week = weekSlider[index]
                    
                    //showing week data using weekview
                    //tag - to identify each week vw separately
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15) //to counter outer vw padding
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
            
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
        .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
            //creating when it reaches 1st/ last page
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
            }
        }
    }
    
    //week view
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View {
        //hstack for days of week
        HStack(spacing: 0) {
            //looping through each date in week data received
            ForEach(week) { day in
                //vw for each date in slider week vw
                VStack(spacing: 8) {
                    //for day name
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    //for date
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        // setting white color for selected date and gray for the others
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .frame(width: 35, height: 35)
                        .background(content: {
                            //checking if this date is selected date and setting bg color dark blue for selected date
                            if isSameDate(day.date, currentDate) {
                                Circle()
                                    .fill(.darkBlue)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation) //to show gliding animation when tapped on a day on week slider 
                            }
                            
                            //Indicator for today's date (cyan dot below the date)
                            if day.date.isToday {
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom) //to push it down
                                    .offset(y: 12) // to put it out of the bg circle
                            }
                        })
                        //in - to give shape to the bg of this vw
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    //updating current date (selected date)
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        //when the offset reaches 15 and if the currentweek is toggled then only generating next set of week
                        if value.rounded() == 15 && createWeek {
                            print("Generate")
                            createWeek = false
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
