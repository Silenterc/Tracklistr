//
//  DjTracklistAppApp.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import SwiftUI
import SwiftData

@main
struct DjTracklistApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Tracklist.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MixOverviewView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
