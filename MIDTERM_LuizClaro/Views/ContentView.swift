//
//  ContentView.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showInfoModalView: Bool = false
    @State var appearCount: Int = 0
    
    @State var chosenCalendar = Calendar(identifier: .gregorian)
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor.dark
        UITabBar.appearance().layer.borderWidth = 1.5
        UITabBar.appearance().layer.borderColor = UIColor.darkAccent.cgColor
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some View {
        TabView{
            CalendarView(calendar: chosenCalendar)
                .tabItem{
                    Label("Calendar", systemImage: "calendar")
                }
            ToDoView(calendar: chosenCalendar)
                .tabItem{
                    Label("ToDo List", systemImage: "checkmark.circle.fill")
                }
            FinanceView(calendar: chosenCalendar)
                .tabItem{
                    Label("Finance", systemImage: "chart.bar.xaxis")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear(perform: {
            onLoad()
        })
        .sheet(isPresented: $showInfoModalView) {
            TutorialView()
        }
        .accentColor(.white)
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // Prevent TutorialView from showing more than once
    func onLoad() {
        if appearCount == 0 {
            showInfoModalView = true
        } else {
            showInfoModalView = false
        }
        if showInfoModalView {
            appearCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension UIColor {
    
    @nonobjc class var sapphire: UIColor {
        return UIColor(red: 36.0 / 255.0, green: 47.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkGreyBlue: UIColor {
        return UIColor(red: 39.0 / 255.0, green: 53.0 / 255.0, blue: 76.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 251.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var dark: UIColor {
        return UIColor(red: 23.0 / 255.0, green: 25.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var darkAccent: UIColor {
        return UIColor(red: 43.0 / 255.0, green: 46.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
    }
    
}
