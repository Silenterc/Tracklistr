//
//  DjTracklistAppApp.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import SwiftUI
import SwiftData

let tracklist = Tracklist.mockTracklist1()
@MainActor
let sharedModelContainer: ModelContainer = {
    let schema = Schema([
        Tracklist.self,
        Deck.self,
        AppTrack.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    do {
        let container = try ModelContainer(for:schema, configurations: [modelConfiguration])
        container.mainContext.insert(tracklist)
        return container
    } catch {
        fatalError("Error initializing")
    }
    
}()
@main
//@MainActor
struct DjTracklistApp: App {
    var body: some Scene {
        WindowGroup {
            MixOverviewView(modelContext: sharedModelContainer.mainContext)
            //TracklistView(modelContext: sharedModelContainer.mainContext, tracklistID: tracklist.id)
            //TracklistInfoView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
