//
//  AddTrackVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 28.01.2024.
//

import Foundation

@Observable
class AddTrackVM {
    var player: Player
    var spotifyTapped: Bool = false
    init(player: Player) {
        self.player = player
    }
}
