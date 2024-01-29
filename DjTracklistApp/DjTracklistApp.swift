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
        Player.self,
        Track.self
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
struct DjTracklistApp: App {
    @ObservedObject var router: NavigationRouter = NavigationRouter(modelContext: sharedModelContainer.mainContext)
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MixOverviewView(modelContext: sharedModelContainer.mainContext)
                    .navigationDestination(for: NavigationRouter.Destination.self) { dest in
                        router.defineViews(for: dest)
                    }
                //TracklistView(modelContext: sharedModelContainer.mainContext, tracklistID: tracklist.id)
                //TracklistInfoView(modelContext: sharedModelContainer.mainContext)
                .modelContainer(sharedModelContainer)
            }
            .environmentObject(router)
        }
    }
}
