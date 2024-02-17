//
//  PlayerVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 16.02.2024.
//

import Foundation
@Observable
class PlayerVM {
    
    var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    /// Validates whether the track doesnt overlap with another -> their positions and durations are not overlapping, so each track has its own place
    func validatePosition(track: Track) -> Bool {
        for secTrack in player.tracks! {
            if secTrack.id == track.id {
                continue
            }
            if track.position < secTrack.positionRightEdge && track.positionRightEdge > secTrack.position {
                return false
            }
        }
        return true
        
    }
}
