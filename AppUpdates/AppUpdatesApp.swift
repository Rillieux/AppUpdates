//
//  AppUpdatesApp.swift
//  AppUpdates
//
//  Created by Perrache on 27.02.2024..
//

import SwiftUI

@main
struct AppUpdatesApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        print("init")
        Updates.imports()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
