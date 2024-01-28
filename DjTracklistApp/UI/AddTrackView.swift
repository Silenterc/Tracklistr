//
//  AddTrackView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 28.01.2024.
//

import SwiftUI
import SwiftData
struct AddTrackView: View {
    @State var viewModel: AddTrackVM
    
    init(player: Player?) {
        let viewModel = AddTrackVM(player: player)
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
                    
                    Button(action: {
                        viewModel.musicApiTapped = true
                    }, label: {
                        inputSelectionCell(image: musicApi, text: "Find via all services")
                    })
                    .tint(.black)
                    
                    
                }
                
                HStack (alignment: .bottom) {
                    let plus = Image(systemName: "plus.app").resizable().frame(width: 45, height: 45)
                    Button(action: {
                        viewModel.manualTapped = true
                    }, label: {
                        inputSelectionCell(image: plus, text: "Add your own")
                    })
                    .tint(.black)
                    
                }
            }
            
            
        }
        .frame(width: 400)
        .navigationDestination(isPresented: $viewModel.spotifyTapped) {
            searchTrackView()
        }
        .navigationDestination(isPresented: $viewModel.musicApiTapped) {
            EmptyView()
        }
        .navigationDestination(isPresented: $viewModel.manualTapped) {
            EmptyView()
        }
        // DOES NOT WORK
        .navigationDestination(for: Track.self) { track in
            Text("Huh")
        }
        
    }
    func searchTrackView() -> some View {
        VStack {
            HStack {
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
                NavigationLink(value: track) {
                    searchedTrackCell(track: track)
                }
            }
        }
    }
    
    func searchedTrackCell(track: Track) -> some View {
        GeometryReader { geometry in
            HStack {
                AsyncImage(url: track.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 50, height: 50)
                
                Text(track.name)
                    .font(.custom(UIConstants.Font.regular, size: 18))
                    .frame(width: geometry.size.width * 0.5, alignment: .leading)
                
                
                Text(track.artistNames.joined(separator: ","))
                    .font(.custom(UIConstants.Font.regular, size: 18))
                
                
            }
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
    return NavigationStack{AddTrackView(player: Player.mockPlayer1())}
}
