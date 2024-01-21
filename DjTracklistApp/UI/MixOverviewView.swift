//
//  MixOverviewView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import SwiftUI
import SwiftData
/**
 View presenting the User's created mixes.
 */
struct MixOverviewView: View {

   // @Environment(\.modelContext) var modelContext
    @State var viewModel: MixOverviewVM
    
    // We need an initializer for injecting the database Context into our VM
    init(modelContext: ModelContext) {
        let viewModel = MixOverviewVM(databaseContext: modelContext)
        //self.viewModel = viewModel
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        NavigationLink(destination: EmptyView()){
                            TracklistCell(viewModel: viewModel, name: "Start a new set")
                        }
                        ForEach(viewModel.tracklists) { tracklist in
                            NavigationLink(destination: EmptyView()) {
                                
                                TracklistCell(viewModel: viewModel, name: tracklist.name, editedAt: tracklist.editedAt)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Mix Overview")
        }
    }
}

extension MixOverviewView {
    /**
     Represents a summary of a tracklist
     */
    struct TracklistCell : View {
        let viewModel: MixOverviewVM
        let name: String
        var editedAt: Date? = nil
        
        var body : some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                    if let date = editedAt{
                        Text("Date: \(date))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
    
}

#Preview {
    MixOverviewView(
        modelContext: try! ModelContainer(
            for: AppTrack.self, Tracklist.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext)
}
