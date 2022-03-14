//
//  MIDTERM_LuizClaroApp.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

let sf = ScaleFactor()

let gradientOne = LinearGradient(gradient: Gradient(colors: [Color("purpleBlue"), Color("bloodOrange")]), startPoint: .top, endPoint: .bottom)
let gradientOneDiagonal = LinearGradient(gradient: Gradient(colors: [Color("bloodOrange"), Color("purpleBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
let gradientTwo = LinearGradient(gradient: Gradient(colors: [Color("yellow"), Color("bloodOrange")]), startPoint: .top, endPoint: .bottom)
let gradientTwoDiagonal = LinearGradient(gradient: Gradient(colors: [Color("bloodOrange"), Color("yellow")]), startPoint: .topLeading, endPoint: .bottomTrailing)
let gradientThree = LinearGradient(gradient: Gradient(colors: [Color("skyBlue"), Color("deepBlue")]), startPoint: .top, endPoint: .bottom)
let gradientThreeDiagonal = LinearGradient(gradient: Gradient(colors: [Color("deepBlue"), Color("skyBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)

let gradientClear = LinearGradient(gradient: Gradient(colors: [.clear, .clear]), startPoint: .top, endPoint: .bottom)

let gradientTextField = LinearGradient(gradient: Gradient(colors: [Color("darkBlue"), Color("bgColorAccent")]), startPoint: .topLeading, endPoint: .bottomTrailing)

@main
struct MIDTERM_LuizClaroApp: App {
    let persistenceController = PersistenceController.shared
    @State private var showLaunchScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    if showLaunchScreen {
                        LaunchView(showLaunch: $showLaunchScreen)
                            .navigationBarHidden(true)
                            .transition(.move(edge: .leading))
                    } else {
                        LoginView()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

//Functions to check amount of days between two dates
extension Date {

    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }

    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
}
