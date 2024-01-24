//
//  Deck.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import Foundation
import SwiftData

@Model
class Deck {
    @Attribute(.unique) let id: UUID
    @Relationship(deleteRule: .cascade, inverse: \AppTrack.deck) var tracks: [AppTrack]
    var tracklist: Tracklist?
    
    init(id: UUID, tracks: [AppTrack], tracklist: Tracklist? = nil) {
        self.id = id
        self.tracks = tracks
        self.tracklist = tracklist
    }
    
}

extension Deck {
    static func mockDeck1() -> Deck {
        Deck(id: UUID(),tracks: [AppTrack.mockSolarSystemTrack(), AppTrack.mockDevotionTrack(), AppTrack.mockDevotionTrack(), AppTrack.mockSolarSystemTrack()])
    }
    static func mockDeck2() -> Deck {
        Deck(id: UUID(),tracks: [AppTrack.mockDevotionTrack(), AppTrack.mockSolarSystemTrack()])
    }
}
