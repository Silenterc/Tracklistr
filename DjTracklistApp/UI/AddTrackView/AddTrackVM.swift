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
    func handleChosenTrack() {
        if chosenTrack != nil {
            if spotifyTapped {
                Task {
                    do {
                        self.chosenTrack = try await apiService?.getTrackWithFeatures(id: chosenTrack!.externalId)
                        // Rounded to 1 decimal place
                        self.chosenTrack!.bpm?.round()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.songChosen = true
                        }
                    } catch {
                        print(error)
                    }
                    
                }
            } else {
                if (chosenTrack!.artistNames.isEmpty) {
                    chosenTrack!.artistNames = searchArtists.components(separatedBy: ",")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.songChosen = true
                }
            }
            
        }
    }
    @MainActor
    func reset() {
        apiService = nil
        tracks.removeAll()
        songChosen = false
        chosenTrack = nil
        searchName = ""
        searchArtists = ""
        
    }
}
