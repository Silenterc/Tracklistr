//
//  TracklistViewVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import Foundation
import SwiftData

@Observable
class TracklistVM {
    
    // Middle man between our VM and SwiftData, used for all Database operations
    var tracklistService: TracklistService
    var tracklistID: UUID
    var tracklist: Tracklist?
    
    var isAddSheetPresented: Bool = false
    var playerToBeAdded: Player?
    init(tracklistService: TracklistService, tracklistID: UUID) {
        self.tracklistService = tracklistService
        self.tracklistID = tracklistID
        fetchTracklist()
    }
    
    func fetchTracklist() {
        do {
            tracklist = try tracklistService.fetchTracklist(id: tracklistID)
            
        } catch {
            // TODO
        }
    }
    
    
}
