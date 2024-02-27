//
//  TracklistViewVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import Foundation
import SwiftData
import SwiftUI
class DragInfo {
    init(draggedPos: CGPoint) {
        self.draggedPos = draggedPos
    }
    var draggedPos: CGPoint
}
@Observable
class TracklistVM {
    
    // Middle man between our VM and SwiftData, used for all Database operations
    var tracklistService: DatabaseService
    var tracklistID: UUID
    var tracklist: Tracklist?
    var players: [Player] = []
    
    var size: CGSize?
    var draggedTrack: Track?
    var dragging: Bool = false
    var dragInfo: CGPoint?
    var srcPlayer: Player?
    var playerSize: CGSize? = CGSize(width: 300, height: 70)
    init(tracklistService: DatabaseService, tracklistID: UUID) {
        self.tracklistService = tracklistService
        self.tracklistID = tracklistID
        fetchTracklist()
        fetchPlayers()
        DragHandler.shared.players = players
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
        } catch {
            // TODO
            print("oh oh")
        }
    }
    
    func updateDragInfo(newOne: CGPoint) {
        dragInfo = newOne
        print(newOne)
    }
    
    
}
