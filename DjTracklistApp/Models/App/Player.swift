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
    @Relationship(deleteRule: .cascade, inverse: \Track.player) var tracks: [Track]?
    /// Order of the player in the tracklist, so for four players it will be 0-3
    let order: Int
    /// The tracklist that this player belongs to
    var tracklist: Tracklist?
    
    init(id: UUID, tracks: [Track]? = [], tracklist: Tracklist? = nil, order: Int) {
        self.id = id
        self.tracks = tracks
        self.tracklist = tracklist
        self.order = order

    }
}

extension Player {
    static func mockPlayer1() -> Player {
        Player(id: UUID(),tracks: [Track.mockSolarSystemTrack(), Track.mockDevotionTrack(), Track.mockFallingTrack(), Track.mockDesireTrack()], order: 0)
    }
    static func mockPlayer2() -> Player {
        Player(id: UUID(),tracks: [Track.mockDevotionTrack(), Track.mockSolarSystemTrack()], order: 1)
    }
    static func mockPlayer3() -> Player {
        Player(id: UUID(),tracks: [Track.mockSolarSystemTrack(), Track.mockDevotionTrack(), Track.mockFallingTrack(), Track.mockDesireTrack()], order: 2)
    }
    static func mockPlayer4() -> Player {
        Player(id: UUID(),tracks: [Track.mockSolarSystemTrack(), Track.mockDevotionTrack(), Track.mockFallingTrack(), Track.mockDesireTrack()], order: 3)
    }
}
