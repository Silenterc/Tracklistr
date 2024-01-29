//
//  TrackDetailVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 29.01.2024.
//

import Foundation

@Observable
class TrackDetailVM {
    var track: Track
    var player: Player
    
    init(track: Track, player: Player) {
        self.track = track
        self.player = player
    }
}
