//
//  PlayerVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 16.02.2024.
//

import Foundation
import SwiftUI
@Observable
class PlayerVM {
    var databaseService: DatabaseService
    var player: Player
    var draggedTrack: Track?
    init(player: Player, databaseService: DatabaseService) {
        self.player = player
        self.databaseService = databaseService
    }
    
    func deleteTrack(track: Track) {
        //databaseService.removeTrack(track: track)
        if let index = player.tracks!.firstIndex(where: {$0.id == track.id}) {
            player.tracks!.remove(at: index)
        }
    }
    
}
