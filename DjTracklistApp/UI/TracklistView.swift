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
    
    init(modelContext: ModelContext, tracklistID: UUID) {
        let viewModel = TracklistVM(databaseContext: modelContext, tracklistID: tracklistID)
        _viewModel = State(initialValue: viewModel)
    }
    
    
    
    
    var body: some View {
        if let tracklist = viewModel.tracklist {
            ZStack {
                HStack {
                    ScrollView(.horizontal){
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(tracklist.decks!) { deck in
                                VStack(alignment: .leading){
                                 
                                    LazyHStack {
                                        ForEach(deck.tracks!) { track in
                                            
                                                //Spacer()
                                                TrackCell(viewModel: .init(track: track, width: 192, height: 62))
                                                
                                                //Spacer()
                                            
                                        }
                                    }
                                    if (deck != tracklist.decks!.last) {
                                        TimeIndicationView(bars: 10.getBars(bpm: Double(viewModel.tracklist!.bpm), timeUnit: .minutes))
    
                                    } else {
                                        Rectangle()
                                            .frame(height: 28)
                                            .frame(maxWidth: .infinity)
                                            .opacity(0)
                                            
                                    }
                                }
                                .frame(maxWidth: .infinity)
                           
                                Spacer()
                            }
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        //.frame(alignment: .center)
                        .offset(x: 0, y: 22)
                    }
                    .scrollTargetBehavior(.viewAligned)
                   
                    
                    
                    
                    Rectangle()
                        .fill(.white)
                        .frame(width: 30)
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .background(.black)
            .frame(maxWidth: .infinity)
        }
    }
}



#Preview(traits: .landscapeLeft) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let tracklist = Tracklist.mockTracklist1()
    container.mainContext.insert(tracklist)
    
    return TracklistView(modelContext: container.mainContext,
                         tracklistID: tracklist.id)
     
}
