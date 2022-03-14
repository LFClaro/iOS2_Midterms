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
    
    @State var menuTapped: Bool = false
    @State var addEventTapped: Bool = false
    @State var screenLoad: Bool = false
    
    private static var now = Date() // Cache now
    
    enum ViewSelected {
        case month, week, fullPageMonth
    }
    
    @State var selectedView = ViewSelected.month
    
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
            
            if(selectedView == .month) {
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Calendar").font(.largeTitle.bold())
                            Text("Lorem Ipsum dolor sit amet.").font(.body).foregroundColor(.gray)
                        }
                        Spacer()
                        Menu {
                            Button("Show Week", action: weekSelected)
                            Button("Show Full Page Month", action: fullMonthSelected)
                        } label: {
                            Image(systemName: "ellipsis.circle").font(.largeTitle)
                                .scaleEffect(menuTapped ? 1.2 : 1)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.8)) {
                                menuTapped.toggle()
                            }
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
                                .transition(.move(edge: .top).combined(with: .opacity))
                            }
                        )
                            .equatable()
                            .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    .padding()
                    
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading){
                            Text("Schedule (\(monthDayFormatter.string(from: selectedDate)))").font(.title2.bold())
                        }
                        Spacer()
                        Button {
                            addEventTapped.toggle()
                        } label: {
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
                .transition(.move(edge: .leading).combined(with: .opacity))
            } else if(selectedView == .week){
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Calendar").font(.largeTitle.bold())
                            Text("Lorem Ipsum dolor sit amet.").font(.body).foregroundColor(.gray)
                        }
                        Spacer()
                        Menu {
                            Button("Show Month", action: monthSelected)
                            Button("Show Full Page Month", action: fullMonthSelected)
                        } label: {
                            Image(systemName: "ellipsis.circle").font(.largeTitle)
                                .scaleEffect(menuTapped ? 1.2 : 1)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.8)) {
                                menuTapped.toggle()
                            }
                        }
                        
                    }
                    .padding()
                    
                    VStack {
                        Image("week").resizable().scaledToFit()
                    }
                    .padding()
                    
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading){
                            Text("Schedule (\(monthDayFormatter.string(from: selectedDate)))").font(.title2.bold())
                        }
                        Spacer()
                        Button {
                            addEventTapped.toggle()
                        } label: {
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
                .transition(.move(edge: .leading).combined(with: .opacity))
            } else if(selectedView == .fullPageMonth) {
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Calendar").font(.largeTitle.bold())
                            Text("Lorem Ipsum dolor sit amet.").font(.body).foregroundColor(.gray)
                        }
                        Spacer()
                        Menu {
                            Button("Show Month", action: monthSelected)
                            Button("Show Week", action: weekSelected)
                        } label: {
                            Image(systemName: "ellipsis.circle").font(.largeTitle)
                                .scaleEffect(menuTapped ? 1.2 : 1)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.8)) {
                                menuTapped.toggle()
                            }
                        }
                        
                    }
                    .padding()
                    
                    ZStack {
                        Image("fullPageCalendar").resizable().scaledToFit()
                        Button {
                            addEventTapped.toggle()
                        } label: {
                            Circle()
                                .fill(Color("AccentColor"))
                                .frame(width: sf.w * 0.15, height: sf.w * 0.15)
                                .overlay {
                                    Image(systemName: "plus").font(.largeTitle)
                                }
                                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                screenLoad = true
            }
        }
        .fullScreenCover(isPresented: $addEventTapped) {
            AddEventView()
        }
    }
    
    func monthSelected() {
        withAnimation(.easeInOut) {
            selectedView = .month
        }
    }
    func weekSelected() {
        withAnimation(.easeInOut) {
            selectedView = .week
        }
    }
    func fullMonthSelected() {
        withAnimation(.easeInOut) {
            selectedView = .fullPageMonth
        }
    }
    
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
