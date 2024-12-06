//
//  PlayerView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 16.02.2024.
//

import SwiftUI
import SwiftData
struct PlayerView: View {
    @State var viewModel: PlayerVM
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(viewModel.player.tracks!) { track in
                
                TrackCell(viewModel: .init(track: track))
                    .highPriorityGesture(TapGesture(count: 2).onEnded({ _ in
                        withAnimation {
                            viewModel.deleteTrack(track: track)
                        }
                    }))
                    .padding(.leading, track.position)
            }
            
            
            
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let player = Player.mockPlayer1()
    container.mainContext.insert(player)
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        ScrollView(.horizontal){
            PlayerView(viewModel:.init(player: player, databaseService: .init(databaseContext: container.mainContext)))
                .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                    router.defineViews(for: destination)
                }
        }
        .scrollIndicators(.never)
    }
    .environmentObject(router)
    

}
