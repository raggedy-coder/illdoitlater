//
//  illdoitlaterApp.swift
//  illdoitlater
//
//  Created by RB de Guzman on 12/26/24.
//

import SwiftUI
import SwiftData

@main
struct illdoitlaterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Todo.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TodayView().modelContainer(sharedModelContainer)
        }
    }
}
