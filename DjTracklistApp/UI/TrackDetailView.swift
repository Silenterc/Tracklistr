//
//  TrackDetailView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 29.01.2024.
//

import SwiftUI
import SwiftData
struct TrackDetailView: View {
    @State var viewModel: TrackDetailVM
    
    init(track: Track, player: Player) {
        let viewModel = TrackDetailVM(track: track, player: player)
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                fontedText(text: "Track name")
                TextField("Enter a name",text: $viewModel.name)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .textFieldStyle(.roundedBorder)
                
                fontedText(text: "Artist names")
                TextField("Enter names separated by a comma",text: $viewModel.artistNames)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .textFieldStyle(.roundedBorder)
                
                fontedText(text: "Total duration of the track")
                HStack {
                    TextField("Minutes", value: $viewModel.durationMinutes, format: .number)
                        .font(.custom(UIConstants.Font.regular, size: 18))
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                    fontedText(text: "minutes")
                    TextField("Seconds", value: $viewModel.durationSeconds, format: .number)
                        .font(.custom(UIConstants.Font.regular, size: 18))
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                    fontedText(text: "seconds")
                }
                fontedText(text: "BPM")
                TextField("Beats Per Minute", value: $viewModel.bpm, format: .number)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                fontedText(text: "Amount of seconds between the start of the track and the first bar")
                TextField("seconds",value: $viewModel.startTimeOffsetSeconds, format: .number)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                fontedText(text: "Number of bars elapsed from the track's start to the beginning of playback")
                TextField("number of bars divisible by 4", value: $viewModel.currentStartTimeBars, format: .number)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                fontedText(text: "Number of bars for the playback duration")
                TextField("number of bars divisible by 4", value: $viewModel.currentDurationBars, format: .number)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Spacer()
                    Button {
                        if viewModel.createTrack() {
                            // navigate etc.
                        }
                    } label: {
                        Text("Submit")
                    }
                    Spacer()
                }
                
                
                
            }
            .padding(16)
        }
    }
    func fontedText(text: String) -> some View {
        Text(text)
            .font(.custom(UIConstants.Font.regular, size: 18))
    }
        
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    let tracklist = Tracklist.mockTracklist1()
    container.mainContext.insert(tracklist)
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        TrackDetailView(track: .mockSolarSystemTrack(), player: .mockPlayer1())
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
}
