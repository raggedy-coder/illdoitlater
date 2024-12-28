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
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TodoView()
//            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
