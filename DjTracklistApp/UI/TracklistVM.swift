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
    var tracklistService: DatabaseService
    var tracklistID: UUID
    var tracklist: Tracklist?
    var players: [Player] = []
    
    var size: CGSize?
    
    init(tracklistService: DatabaseService, tracklistID: UUID) {
        self.tracklistService = tracklistService
        self.tracklistID = tracklistID
        fetchTracklist()
        fetchPlayers()
    }
    
    func fetchTracklist() {
        do {
            tracklist = try tracklistService.fetchTracklist(id: tracklistID)
            
        } catch {
            // TODO
            print("oh oh")
        }
    }
    
    func fetchPlayers() {
        do {
            players = try tracklistService.fetchPlayers(id: tracklistID)
            players.forEach({print($0.order)})
        } catch {
            // TODO
            print("oh oh")
        }
    }
    
    
}
