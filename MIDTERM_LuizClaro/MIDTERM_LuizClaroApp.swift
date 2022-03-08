//
//  MIDTERM_LuizClaroApp.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-08.
//

import SwiftUI

@main
struct MIDTERM_LuizClaroApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
