//
//  TracklistInfoVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 25.01.2024.
//

import Foundation
import SwiftData
@Observable
class TracklistInfoVM {
    var tracklistService: TracklistService
    var tracklistID: UUID
    var tracklist: Tracklist
    
    
    let toBeCreated: Bool
    var isCreateButtonDisabled: Bool {
        return currentBpm == nil || currentDurationMinutes == nil || currentName.isEmpty
    }
    var decksCount = 4
    var currentBpm: Double?
    var currentDurationMinutes: Int?
    var currentName: String = ""
    
    init(tracklistService: TracklistService, tracklistID: UUID? = nil) {
        self.tracklistService = tracklistService
        if let id = tracklistID {
            toBeCreated = false
            do {
                self.tracklistID = id
                self.tracklist = try tracklistService.fetchTracklist(id: id)
            } catch {
                fatalError("Couldnt fetch tracklist")
            }
        } else {
            toBeCreated = true
            let tracklistNew = Tracklist(id: UUID(), name: "", editedAt: Date(), bpm: 0, durationMinutes: 0)
            self.tracklistID = tracklistNew.id
            self.tracklist = tracklistNew
        }
    }
    
    func updateTracklist() {
        tracklist.bpm = currentBpm!
        tracklist.durationMinutes = currentDurationMinutes!
        tracklist.name = currentName
        // Right now we only support 4 decks so they get added here and also we have created a new Tracklist so it gets added to the db
        if (toBeCreated) {
            tracklistService.insertTracklist(tracklist: tracklist)
            //tracklist.decks.append(contentsOf: repeatElement(Deck(id: UUID(), tracks: [], tracklist: tracklist), count: decksCount))
            tracklist.decks!.append(contentsOf: repeatElement(Deck(id: UUID(), tracklist: tracklist), count: 4))
        }
        
        
    }
    
}
