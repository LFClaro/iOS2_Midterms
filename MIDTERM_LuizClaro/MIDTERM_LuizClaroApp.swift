//
//  MIDTERM_LuizClaroApp.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

let sf = ScaleFactor()

let gradientOne = MainGradient(startColor: Color("purpleBlue"), endColor: Color("bloodOrange"))
let gradientTwo = MainGradient(startColor: Color("yellow"), endColor: Color("bloodOrange"))
let gradientThree = MainGradient(startColor: Color("skyBlue"), endColor: Color("deepBlue"))
let gradientClear = MainGradient(startColor: .clear, endColor: .clear)

let gradientTextField = MainGradient(startColor: Color("bgColor"), endColor: Color("darkBlue"), startPoint: .leading, endPoint: .trailing)

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
                        ContentView()
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
