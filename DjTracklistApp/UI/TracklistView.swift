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
        HStack {
            
            VStack {
                ForEach(viewModel.tracklist.decks) { deck in
                    LazyHStack {
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            Rectangle()
                .fill(.white)
                .frame(width: 30)
        }
        
        
    }
}



#Preview(traits: .landscapeLeft) {
    TracklistView(
        modelContext: try! ModelContainer(
        for: Tracklist.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext,
        tracklist: .mockTracklist1())
     
}
