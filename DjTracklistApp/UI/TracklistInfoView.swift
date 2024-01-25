//
//  TracklistInfoView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 25.01.2024.
//

import SwiftUI
import SwiftData
/**
 View which lets the user edit the data of either an existing tracklist or a new one
 */
struct TracklistInfoView: View {
    @State var viewModel: TracklistInfoVM
    init(modelContext: ModelContext, tracklistID: UUID? = nil) {
        let viewModel = TracklistInfoVM(tracklistService: TracklistService(databaseContext: modelContext), tracklistID: tracklistID)
        _viewModel = State(initialValue: viewModel)
    }
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    // TODO CUSTOM TEXTS FOR ROBOTO
                    Text("Name:")
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                    TextField("Enter name", text: $viewModel.currentName)
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("BPM:")
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                    TextField("Enter BPM",value: $viewModel.currentBpm, format: .number)
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Length:")
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                    TextField("Enter duration in minutes",value: $viewModel.currentDurationMinutes, format: .number)
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    
                    Text("Number of Decks:")
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                    TextField("4", value: $viewModel.decksCount, formatter: NumberFormatter())
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                        .disabled(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    HStack {
                        Button("Cancel") {
                            // Handle cancel action
                        }
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                        .foregroundColor(.red)
                        
                        Spacer()
                        Button(viewModel.toBeCreated ? "Create" : "Save") {
                            viewModel.updateTracklist()
                            viewModel.goToTracklistView = true
                        }
                        .font(.custom(UIConstants.Font.regular, fixedSize: 18))
                        .disabled(viewModel.isCreateButtonDisabled)
                        
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 50)
                    
                }
                .frame(alignment: .top)
                .padding(16)
                Spacer()
            }
            .padding(.top, 40)
        }
        .navigationDestination(isPresented: $viewModel.goToTracklistView) {
            TracklistView(modelContext: viewModel.tracklistService.databaseContext, tracklistID: viewModel.tracklist.id)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    //let tracklist = Tracklist.mockTracklist1()
    //container.mainContext.insert(tracklist)
    
    return TracklistInfoView(modelContext: container.mainContext)
}
