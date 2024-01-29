//
//  TrackDetailView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 29.01.2024.
//

import SwiftUI
import SwiftData
struct TrackDetailView: View {
    @State var viewModel: TrackDetailVM
    
    init(track: Track, player: Player) {
        let viewModel = TrackDetailVM(track: track, player: player)
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {
        // TODO
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let tracklist = Tracklist.mockTracklist1()
    container.mainContext.insert(tracklist)
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        TrackDetailView(track: .mockSolarSystemTrack(), player: .mockPlayer1())
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
}
