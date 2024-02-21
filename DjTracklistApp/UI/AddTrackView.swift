//
//  AddTrackView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 28.01.2024.
//

import SwiftUI
import SwiftData
import AsyncDownSamplingImage
struct AddTrackView: View {
    @State var viewModel: AddTrackVM
    @EnvironmentObject var router: NavigationRouter
    
    init(player: Player?, bpm: Float) {
        let viewModel = AddTrackVM(player: player, bpm: bpm)
        _viewModel = State(initialValue: viewModel)
    }
    var body: some View {

        VStack(alignment: .center) {
            
            HStack {
                Spacer()
                Text("Add a Track")
                    .font(.custom(UIConstants.Font.bold, fixedSize: 30))
                Spacer()
            }
            
            VStack (alignment: .leading) {
                HStack (alignment: .bottom) {
                    let musicApi = Image("MusicApi").resizable()
                        .aspectRatio(contentMode: .fit)
                    Button(action: {
                        viewModel.apiService = SpotifyService(apiHandler: SpotifyAPIHandler())
                        viewModel.spotifyTapped = true
                    }, label: {
                        inputSelectionCell(image: Image("Spotify"), text: "Find via Spotify")
                    })
                    .tint(.black)
                    .navigationDestination(isPresented: $viewModel.spotifyTapped) {
                        searchTrackView()
                    }
                    
                    Button(action: {
                        viewModel.apiService = MusicApiService(apiHandler: MusicAPIHandler())
                        viewModel.musicApiTapped = true
                    }, label: {
                        inputSelectionCell(image: musicApi, text: "Find via all services")
                    })
                    .tint(.black)
                    .navigationDestination(isPresented: $viewModel.musicApiTapped) {
                        searchTrackView()
                    }
                    
                }
                
                HStack (alignment: .bottom) {
                    let plus = Image(systemName: "plus.app").resizable().frame(width: 45, height: 45)
                    Button(action: {
                        viewModel.chosenTrack = .init(id: UUID(), externalId: "", name: "", artistNames: [], albumName: "", originalDuration: 0, bpm: nil)
                        viewModel.manualTapped = true
                    }, label: {
                        inputSelectionCell(image: plus, text: "Add your own")
                    })
                    .tint(.black)
                    .navigationDestination(isPresented: $viewModel.manualTapped) {
                        TrackDetailView(track: viewModel.chosenTrack, player: viewModel.player, bpm: viewModel.bpm)
                    }
                    
                }
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.reset()
        }
        .frame(width: 400)
        
    }
    
    func searchTrackView() -> some View {
        VStack {
            HStack() {
                TextField("Track name (required)", text: $viewModel.searchName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Artists (separated by comma)", text: $viewModel.searchArtists)
                    .textFieldStyle(.roundedBorder)
                Button("Submit") {
                    Task {
                        await viewModel.searchTracks()
                    }
                    
                }
                .disabled(viewModel.searchName.isEmpty)
                
            }
            .padding(16)
            List(viewModel.tracks, id: \.id) { track in
                Button {
                    viewModel.chosenTrack = track
                    viewModel.handleChosenTrack()
                    
                } label: {
                    searchedTrackCell(track: track)
                }
                .tint(.black)
                .padding(12)
                
            }
            .navigationDestination(isPresented: $viewModel.songChosen) {
                TrackDetailView(track: viewModel.chosenTrack, player: viewModel.player, bpm: viewModel.bpm)
            }
        }
        .padding(4)
    }
    
    
    func searchedTrackCell(track: Track) -> some View {
        GeometryReader { geometry in
            HStack() {
                AsyncDownSamplingImage(url: track.imageUrl, downsampleSize: CGSize(width: 100, height: 100)){
                    image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                } fail: { error in
                    EmptyView()
                    
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 50, height: 50)
                     
                Text(track.name)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .frame(width: geometry.size.width * 0.5, alignment: .leading)
                
                
                Text(track.artistNames.joined(separator: ","))
                    .font(.custom(UIConstants.Font.regular, size: 18))
            }
            .frame(height: geometry.size.height)
        }
    }
    
    
    func inputSelectionCell(image: some View, text: String) -> some View {
        VStack {
            
            image
            
            Text(text)
                .font(.custom(UIConstants.Font.regular, fixedSize: 16))
            
        }
        .frame(width: 150)
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Tracklist.self, configurations: config)
    @ObservedObject var router = NavigationRouter(modelContext: container.mainContext)
    return NavigationStack(path: $router.path) {
        AddTrackView(player: Player.mockPlayer1(), bpm: 175)
            .navigationDestination(for: NavigationRouter.Destination.self) { destination in
                router.defineViews(for: destination)
            }
    }
    .environmentObject(router)
}
