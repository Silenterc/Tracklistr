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
    
    init(modelContext: ModelContext, tracklist: Tracklist) {
        let viewModel = TracklistVM(databaseContext: modelContext, tracklist: tracklist)
        _viewModel = State(initialValue: viewModel)
    }
    
    
    
    
    var body: some View {
        
        ZStack {
            HStack {
                VStack(spacing: 0) {
                    ForEach(viewModel.tracklist.decks) { deck in
                        VStack{
                            LazyHStack {
                                ForEach(deck.tracks) { track in
                                    VStack{
                                        //Spacer()
                                        TrackCell(track: track)
                                        //Spacer()
                                    }
                                }
                            }
                            if (deck != viewModel.tracklist.decks.last) {
                                TimeIndicationView(bars: 10.getBars(bpm: Double(viewModel.tracklist.bpm), timeUnit: .minutes))
                            } else {
                                Rectangle()
                                    .frame(height: 28)
                                    .frame(maxWidth: .infinity)
                                    .opacity(0)
                            }
                        }
                        Spacer()
                    }
                    
                    
                    
                }
                .frame(alignment: .center)
                .offset(x: 0, y: 22)
                
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 30)
            }
            VStack{
                
//                ForEach(0 ..< (viewModel.tracklist.decks.count == 1 ? 1 : (viewModel.tracklist.decks.count - 1)),
//                        id: \.self) { num in
//                    Spacer()
//                    TimeIndicationView(bars: 10.getBars(bpm: Double(viewModel.tracklist.bpm), timeUnit: .minutes))
//                    if (num == viewModel.tracklist.decks.count - 2) {
//                        Spacer()
//                    }
//
//                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(.white)
    }
}



#Preview(traits: .landscapeLeft) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let tracklist = Tracklist.mockTracklist1()
    container.mainContext.insert(tracklist)
    
    return TracklistView(modelContext: container.mainContext,
                  tracklist: tracklist)
     
}
