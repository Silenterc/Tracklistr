//
//  Deck.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import Foundation
import SwiftData
/// A class respresenting one player - A collection of songs which will be played on a player such as a CDJ
@Model
class Player {
    @Attribute(.unique) let id: UUID
    /// The tracks present of this player
    @Relationship(deleteRule: .cascade, inverse: \AppTrack.player) var tracks: [AppTrack]?
    /// The tracklist that this player belongs to
    var tracklist: Tracklist?
    
    init(id: UUID, tracks: [AppTrack]? = [], tracklist: Tracklist? = nil) {
        self.id = id
        self.tracks = tracks
        self.tracklist = tracklist

    }
}

extension Player {
    static func mockPlayer1() -> Player {
        Player(id: UUID(),tracks: [AppTrack.mockSolarSystemTrack(), AppTrack.mockDevotionTrack(), AppTrack.mockDevotionTrack(), AppTrack.mockSolarSystemTrack()])
    }
    static func mockPlayer2() -> Player {
        Player(id: UUID(),tracks: [AppTrack.mockDevotionTrack(), AppTrack.mockSolarSystemTrack()])
    }
}
