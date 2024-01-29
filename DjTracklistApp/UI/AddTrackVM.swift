//
//  AddTrackVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 28.01.2024.
//

import Foundation

@Observable
class AddTrackVM {
    var player: Player?
    var apiService: ApiService?
    var tracks: [Track] = []
    
    var spotifyTapped: Bool = false
    var musicApiTapped: Bool = false
    var manualTapped: Bool = false
    var searchName: String = ""
    var searchArtists: String = ""
    var textLen: CGFloat = .zero
    
    init(player: Player?) {
        self.player = player
    }
    
    func searchTracks() async {
        
            do {
                print("Here")
                tracks = try await apiService?.searchTracks(nameQuery: searchName, artistsQuery: searchArtists) ?? []
            } catch {
                print(error)
            }
        
        
    }
}
