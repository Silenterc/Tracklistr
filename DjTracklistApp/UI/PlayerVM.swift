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
    
    var player: Player
    var draggedTrack: Track?
    init(player: Player) {
        self.player = player
    }
    
}
