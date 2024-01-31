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
    var bpm: Float?
    var apiService: ApiService?
    var tracks: [Track] = []
    
    var spotifyTapped: Bool = false
    var musicApiTapped: Bool = false
    var manualTapped: Bool = false
    var songChosen: Bool = false
    var chosenTrack: Track?
    var searchName: String = ""
    var searchArtists: String = ""
    var textLen: CGFloat = .zero
    
    init(player: Player?, bpm: Float?) {
        self.player = player
        self.bpm = bpm
    }
    
    func searchTracks() async {
            do {
                tracks = try await apiService?.searchTracks(nameQuery: searchName, artistsQuery: searchArtists) ?? []
            } catch {
                print(error)
            }
        
        
    }
    @MainActor
    func handleSpotifyTrack() {
        if chosenTrack != nil && spotifyTapped {
            Task {
                do {
                    self.chosenTrack = try await apiService?.getTrackWithFeatures(id: chosenTrack!.externalId)
                    // Rounded to 1 decimal place
                    self.chosenTrack!.bpm?.round()
                    songChosen = true
                } catch {
                    print(error)
                }
        
            }
        }
    }
}
