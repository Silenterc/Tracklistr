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
    @Binding var draggedTrack: Track?
    @Binding var srcPlayer: Player?
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.black
                .frame(maxWidth: .infinity)
            ForEach(viewModel.player.tracks!) { track in
                
                TrackCell(viewModel: .init(track: track))
                    .onTapGesture(count: 2) {
                        if let index = viewModel.player.tracks!.firstIndex(where: {$0.id == track.id}) {
                            viewModel.player.tracks!.remove(at: index)
                        }
                    }
                    .onDrag {
                        draggedTrack = track
                        srcPlayer = viewModel.player
                        return NSItemProvider(object: NSString())
                    }
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
            PlayerView(viewModel:.init(player: player), draggedTrack: .constant(nil), srcPlayer: .constant(nil))
                .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                    router.defineViews(for: destination)
                }
        }
        .scrollIndicators(.never)
    }
    .environmentObject(router)
    

}
