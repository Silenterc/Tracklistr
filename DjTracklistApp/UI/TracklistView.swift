//
//  TracklistView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI
import SwiftData

struct TracklistView: View {
    @State var viewModel: TracklistVM
    @EnvironmentObject var router: NavigationRouter
    init(modelContext: ModelContext, tracklistID: UUID) {
        let viewModel = TracklistVM(tracklistService: DatabaseService(databaseContext: modelContext), tracklistID: tracklistID)
        _viewModel = State(initialValue: viewModel)
    }
    
    
    
    
    var body: some View {
        if let tracklist = viewModel.tracklist {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    ZStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(viewModel.players) { player in
                                VStack(alignment: .leading) {
                                    Spacer()
                                    PlayerView(viewModel: .init(player: player))
                                    Spacer()
                                   
                                }
                             
                                
                                
                            }
                            
                            
                            
                        }
                        .useSize { size in
                            viewModel.size = size
                            
                        }
                        // MAYBE MAKE THE SIZE EQUAL TO THE WHOLE SET LENGTH
                        //.frame(maxWidth: .infinity)
                        VStack {
                            ZStack {
                                let part =  (viewModel.size?.height ?? 0) / 4
                                ForEach(1..<4) { i in
                                    TimeIndicationView(bars: (viewModel.tracklist?.durationMinutes.getBars(bpm: viewModel.tracklist!.bpm, timeUnit: .minutes))!)
                                        .offset(y: part * CGFloat(i) - UIConstants.Indicator.Big.height / 2)
                                }
                               
                            }
                            Spacer()
                        }
                    }
                    
                }
                .scrollTargetBehavior(.viewAligned)
            
                
                TrackAddBar(tracklist: tracklist)
      
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .background(.black)
            .frame(maxWidth: .infinity)
            //.navigationBarBackButtonHidden()
            
        }
        
    }
    
    func TrackAddBar(tracklist: Tracklist) -> some View {
        VStack {
            ForEach(viewModel.players) { player in
                Spacer()
                Button {
                    router.navigateTo(destination: .addTrackView(player: player, bpm: tracklist.bpm))
                } label: {
                    Image(systemName: "plus.app")
                        .resizable()
                        .tint(Color.cellBackground)
                        .frame(width: 25, height: 25)
                }
                Spacer()
                
            }
        }
        .background(.black)
        .frame(width: 30)
    }
    
    
}



#Preview(traits: .landscapeLeft) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let tracklist = Tracklist.mockTracklist1()
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
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        TracklistView(modelContext: container.mainContext, tracklistID: tracklist.id)
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
    
}
