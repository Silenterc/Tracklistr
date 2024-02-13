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
        let viewModel = TracklistVM(tracklistService: TracklistService(databaseContext: modelContext), tracklistID: tracklistID)
        _viewModel = State(initialValue: viewModel)
    }
    
    
    
    
    var body: some View {
        if let tracklist = viewModel.tracklist {
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    ZStack {
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(tracklist.players!) { player in
                                VStack(alignment: .leading) {
                                    Spacer()
                                    HStack (spacing: 0) {
                                        ForEach(player.tracks!) { track in
                                            
                                            TrackCell(viewModel: .init(track: track))
                                                .onTapGesture(count: 2) {
                                                    if let index = player.tracks!.firstIndex(where: {$0.id == track.id}) {
                                                        player.tracks!.remove(at: index)
                                                    }
                                                }
                                                .frame(alignment: .leading)
                                            
                                        }
                                        // TEMPORARY
                                        Spacer()
                                    }
                                    Spacer()
                                   
                                  
                                    
                                }
                             
                                
                                
                            }
                            
                            
                            
                        }
                        .useSize { size in
                            viewModel.size = size
                            
                        }
                        .frame(maxWidth: .infinity)
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
            ForEach(tracklist.players!) { player in
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
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        TracklistView(modelContext: container.mainContext, tracklistID: tracklist.id)
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
    
}
