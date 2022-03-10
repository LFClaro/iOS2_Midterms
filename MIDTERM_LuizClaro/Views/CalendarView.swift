//
//  CalendarView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-09.
//

import Foundation
import SwiftUI
import LoremSwiftum

struct CalendarView: View {
    private let calendar: Calendar
    private let yearFormatter: DateFormatter
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let hourFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let monthDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter
    
    @State private var selectedDate = Self.now
    
    @State private var fullDay = DateInterval(start: Self.now, duration: 1440.0)
    
    private static var now = Date() // Cache now
    
    init(calendar: Calendar) {
        self.calendar = calendar
        
        self.yearFormatter = DateFormatter()
        self.monthFormatter = DateFormatter()
        self.dayFormatter = DateFormatter()
        self.hourFormatter = DateFormatter()
        self.weekDayFormatter = DateFormatter()
        self.monthDayFormatter = DateFormatter()
        self.fullFormatter = DateFormatter()
        
        self.yearFormatter.dateFormat = "yyyy"
        self.monthFormatter.dateFormat = "MMMM"
        self.dayFormatter.dateFormat = "d"
        self.hourFormatter.dateFormat = "HH:mm"
        self.weekDayFormatter.dateFormat = "EEE"
        self.monthDayFormatter.dateFormat = "MMM d"
        self.fullFormatter.dateFormat = "MMMM d, yyyy"
        
        self.yearFormatter.calendar = calendar
        self.monthFormatter.calendar = calendar
        self.dayFormatter.calendar = calendar
        self.hourFormatter.calendar = calendar
        self.weekDayFormatter.calendar = calendar
        self.monthDayFormatter.calendar = calendar
        self.fullFormatter.calendar = calendar
    }
    
    var body: some View {
        ZStack{
            Color("bgColor").edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Calendar").font(.largeTitle.bold())
                        Text("Lorem Ipsum dolor sit amet.").font(.body)
                    }
                    Spacer()
                    Menu {
                        Button("Show Week", action: placeOrder)
                        Button("Show Full Page Month", action: adjustOrder)
                    } label: {
                        Image(systemName: "ellipsis.circle").font(.largeTitle)
                    }
                    
                }
                .padding()
                
                VStack {
                    CalendarComponentView(
                        calendar: calendar,
                        date: $selectedDate,
                        content: { date in
                            Button(action: { selectedDate = date }) {
                                Text("00")
                                    .padding(8)
                                    .foregroundColor(.clear)
                                    .background(
                                        calendar.isDate(date, inSameDayAs: selectedDate) ? gradientOne
                                        : calendar.isDateInToday(date) ? gradientClear
                                        : gradientClear
                                    )
                                    .cornerRadius(20)
                                    .accessibilityHidden(true)
                                    .overlay(
                                        Text(dayFormatter.string(from: date))
                                            .foregroundColor(.white)
                                    )
                            }
                        },
                        trailing: { date in
                            Text(dayFormatter.string(from: date))
                                .foregroundColor(.gray)
                        },
                        header: { date in
                            Text(weekDayFormatter.string(from: date))
                                .foregroundColor(.gray)
                        },
                        title: { date in
                            HStack {
                                Button {
                                    withAnimation {
                                        guard let newDate = calendar.date(
                                            byAdding: .month,
                                            value: -1,
                                            to: selectedDate
                                        ) else {
                                            return
                                        }
                                        
                                        selectedDate = newDate
                                    }
                                } label: {
                                    Label(
                                        title: { Text("Previous") },
                                        icon: { Image(systemName: "chevron.left") }
                                    )
                                        .labelStyle(IconOnlyLabelStyle())
                                        .padding(.horizontal)
                                        .frame(maxHeight: .infinity)
                                }
                                Spacer()
                                Text("\(monthFormatter.string(from: date)) \(yearFormatter.string(from: date))")
                                    .font(.headline)
                                    .padding()
                                Spacer()
                                Button {
                                    withAnimation {
                                        guard let newDate = calendar.date(
                                            byAdding: .month,
                                            value: 1,
                                            to: selectedDate
                                        ) else {
                                            return
                                        }
                                        
                                        selectedDate = newDate
                                    }
                                } label: {
                                    Label(
                                        title: { Text("Next") },
                                        icon: { Image(systemName: "chevron.right") }
                                    )
                                        .labelStyle(IconOnlyLabelStyle())
                                        .padding(.horizontal)
                                        .frame(maxHeight: .infinity)
                                }
                            }
                            .padding(.bottom, 6)
                        }
                    )
                        .equatable()
                }
                .padding()
                
                HStack(alignment: .bottom){
                    VStack(alignment: .leading){
                        Text("Schedule (\(monthDayFormatter.string(from: selectedDate)))").font(.title2.bold())
                    }
                    Spacer()
                    NavigationLink(destination: AddEventView()) {
                        Text("Add Event").font(.body)
                    }
                }
                .padding()
                
                ScrollView {
                    HStack {
                        ZStack(alignment: .top){
                            VStack(spacing: 24) {
                                ForEach(hourIteration(), id: \.self) { hour in
                                    HStack {
                                        Text(hourFormatter.string(from: hour))
                                            .font(.caption)
                                            .frame(width: sf.w * 0.1, height: sf.h * 0.06, alignment: .center)
                                        VStack {
                                            Divider()
                                        }
                                    }
                                }
                            }
                            Spacer()
                            EventComponent(gradient: gradientOne, sentences: 0, cardHeight: sf.h * 0.1, y: sf.h * 0.1)
                            EventComponent(gradient: gradientTwo, sentences: 3, y: sf.h * 0.3)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
    }
    
    func placeOrder() { }
    func adjustOrder() { }
    
    func hourIteration() -> [Date] {
        // Iterate by 1 hour
        let hourDurationInSeconds: TimeInterval = 60*60
        let dayDurationInSeconds: TimeInterval = 60*60*23
        
        var hours = [Date]()
        
        for hour in stride(from: calendar.startOfDay(for: selectedDate), to: selectedDate.advanced(by: dayDurationInSeconds), by: hourDurationInSeconds) {
            
            hours.append(hour)
        }
        return hours
    }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(calendar: Calendar(identifier: .gregorian))
    }
}

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }
    
    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}
