//
//  DjTracklistAppApp.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import SwiftUI
import SwiftData
import SwiftDataTransferrable
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
        let player0 = Player.mockPlayer1()
        let player1 = Player.mockPlayer2()
        let player2 = Player.mockPlayer3()
        let player3 = Player.mockPlayer4()
        container.mainContext.insert(player0)
        container.mainContext.insert(player1)
        container.mainContext.insert(player2)
        container.mainContext.insert(player3)
        player0.tracklist = tracklist
        player1.tracklist = tracklist
        player2.tracklist = tracklist
        player3.tracklist = tracklist
        
        tracklist.players!.forEach { player in
            player.tracks!.forEach { track in
                track.player = player
            }
        }
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
                //Testing()
                MixOverviewView(modelContext: sharedModelContainer.mainContext)
                   .navigationDestination(for: NavigationRouter.Destination.self) { dest in
                        router.defineViews(for: dest)
                    }
                //ContentView()
                //TracklistView(modelContext: sharedModelContainer.mainContext, tracklistID: tracklist.id)
                //TracklistInfoView(modelContext: sharedModelContainer.mainContext)
                .modelContainer(sharedModelContainer)
                .swiftDataTransferrable(exportedUTType: "com.YourTeam.persistentModelID", modelContext: sharedModelContainer.mainContext)
            }
            .environmentObject(router)
        }
    }
}
