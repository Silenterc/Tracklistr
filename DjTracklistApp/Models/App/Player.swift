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
    /// The tracklist that this player belongs to
    var tracklist: Tracklist?
    
    init(id: UUID, tracks: [Track]? = [], tracklist: Tracklist? = nil) {
        self.id = id
        self.tracks = tracks
        self.tracklist = tracklist

    }
}

extension Player {
    static func mockPlayer1() -> Player {
        Player(id: UUID(),tracks: [Track.mockSolarSystemTrack(), Track.mockDevotionTrack(), Track.mockFallingTrack(), Track.mockDesireTrack()])
    }
    static func mockPlayer2() -> Player {
        Player(id: UUID(),tracks: [Track.mockDevotionTrack(), Track.mockSolarSystemTrack()])
    }
}
