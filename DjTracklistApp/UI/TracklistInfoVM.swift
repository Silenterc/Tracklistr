//
//  TracklistInfoVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 25.01.2024.
//

import Foundation
import SwiftData
/**
 ViewModel for the TracklistInfoView
 */
@Observable
class TracklistInfoVM {
    /// Service responsible for persisting tracklist data
    var tracklistService: DatabaseService
    var tracklistID: UUID
    var tracklist: Tracklist
    
    /// Will the new tracklist be crated or is it already an existing one being edited
    let toBeCreated: Bool
    /// Checks if the user has input all the necessary data
    var isCreateButtonDisabled: Bool {
        return currentBpm == nil || currentDurationMinutes == nil || currentName.isEmpty
    }
    /// The amount of decks/players during the set
    var decksCount = 4
    /// Currently chosen bpm  by the user
    var currentBpm: Float?
    /// Currently chosen duration in minutes by the user
    var currentDurationMinutes: UInt?
    /// Currently chosen name of the palylist
    var currentName: String = ""
    /// For navigation purposes, signals whether we are ready to navigate to TracklistView
    var goToTracklistView = false
    
    /// Initializer
    /// - Parameter tracklistService: SwiftData Tracklist repository
    /// - Parameter tracklistID: If we are editing an existing tracklist, we need its ID
    init(tracklistService: DatabaseService, tracklistID: UUID? = nil) {
        self.tracklistService = tracklistService
        // If an existing tracklist gets edited
        if let id = tracklistID {
            toBeCreated = false
            do {
                self.tracklistID = id
                self.tracklist = try tracklistService.fetchTracklist(id: id)
            } catch {
                fatalError("Couldnt fetch tracklist")
            }
        } else {
            // If a new tracklist is abotu to be created
            toBeCreated = true
            let tracklistNew = Tracklist(id: UUID(), name: "", editedAt: Date(), bpm: 0, durationMinutes: 0)
            self.tracklistID = tracklistNew.id
            self.tracklist = tracklistNew
        }
    }
    /// Sets all the newly input properties of the tracklist and make sure it gets saved to the db
    func updateTracklist() {
        tracklist.bpm = currentBpm!
        tracklist.durationMinutes = currentDurationMinutes!
        tracklist.name = currentName
        // Right now we only support 4 decks so they get added here and also we have created a new Tracklist so it gets added to the db
        if (toBeCreated) {
            tracklistService.insertTracklist(tracklist: tracklist)
            let player0 = Player(id: UUID(), order: 0)
            let player1 = Player(id: UUID(), order: 1)
            let player2 = Player(id: UUID(), order: 2)
            let player3 = Player(id: UUID(), order: 3)
            tracklistService.insertPlayer(player: player0)
            tracklistService.insertPlayer(player: player1)
            tracklistService.insertPlayer(player: player2)
            tracklistService.insertPlayer(player: player3)
            player0.tracklist = tracklist
            player1.tracklist = tracklist
            player2.tracklist = tracklist
            player3.tracklist = tracklist
        }
        
        
    }
    
}
