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
    var currentBpm: Int?
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
            let tracklistDone = Tracklist(id: UUID(), decks: [], name: "", editedAt: Date(), bpm: 0)
            self.tracklistID = tracklistDone.id
            self.tracklist = tracklistDone
        }
    }
    
}
