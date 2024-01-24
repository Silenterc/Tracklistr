//
//  Playlist.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation
import SwiftData

@Model
class Tracklist {
    @Attribute(.unique) let id: UUID
    @Relationship(deleteRule: .cascade, inverse: \Deck.tracklist) var decks: [Deck]
    var name: String
    var editedAt: Date
    var bpm: Int
    
    init(id: UUID, decks: [Deck], name: String, editedAt: Date, bpm: Int) {
        self.id = id
        self.decks = decks
        self.name = name
        self.editedAt = editedAt
        self.bpm = bpm
    }
    
}

extension Tracklist {
    static func mockTracklist1() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/11/29 21:00")!
        return Tracklist(id: UUID(), decks: [Deck.mockDeck1(), Deck.mockDeck2(), Deck.mockDeck1(), Deck.mockDeck1()], name: "Silence 10", editedAt: date, bpm: 175)
    }
    
    static func mockTracklist2() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/12/24 16:00")!
        return Tracklist(id: UUID(), decks: [Deck.mockDeck1(), Deck.mockDeck2()], name: "Silence 11", editedAt: date, bpm: 174)
    }
}
