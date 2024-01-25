//
//  TracklistInfoView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 25.01.2024.
//

import SwiftUI
import SwiftData
struct TracklistInfoView: View {
    @State var viewModel: TracklistInfoVM
    init(modelContext: ModelContext, tracklistID: UUID? = nil) {
        let viewModel = TracklistInfoVM(tracklistService: TracklistService(databaseContext: modelContext), tracklistID: tracklistID)
        _viewModel = State(initialValue: viewModel)
    }
    
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 16) {
                Text("Name:")
                TextField("Enter name", text: $viewModel.currentName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("BPM:")
                TextField("Enter BPM",value: $viewModel.currentBpm, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Length:")
                TextField("Enter duration in minutes",value: $viewModel.currentDurationMinutes, format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                
                Text("Number of Decks:")
                TextField("4", value: $viewModel.decksCount, formatter: NumberFormatter())
                    .disabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Button("Cancel") {
                        // Handle cancel action
                    }
                    .foregroundColor(.red)
                    
                    Spacer()
                    Button(viewModel.toBeCreated ? "Create" : "Save") {
                        // Handle create or save action
                    }
                    .disabled(viewModel.isCreateButtonDisabled)
                }
                .padding(.top, 20)
            }
            .frame(alignment: .top)
            .padding(16)
            Spacer()
        }
        .padding(.top, 40)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    //let tracklist = Tracklist.mockTracklist1()
    //container.mainContext.insert(tracklist)
    
    return TracklistInfoView(modelContext: container.mainContext)
}
