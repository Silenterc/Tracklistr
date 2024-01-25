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
    @Relationship(deleteRule: .cascade, inverse: \Deck.tracklist) var decks: [Deck]?
    var name: String
    var editedAt: Date
    var bpm: Double
    var durationMinutes: Int
    
    init(id: UUID, decks: [Deck]? = [], name: String, editedAt: Date, bpm: Double, durationMinutes: Int) {
        self.id = id
        self.decks = decks
        self.name = name
        self.editedAt = editedAt
        self.bpm = bpm
        self.durationMinutes = durationMinutes
        //setDecks(decks: decks)
    }
    
    func setDecks(decks: [Deck]) {
        self.decks = decks
    }
    
}

extension Tracklist {
    static func mockTracklist1() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/11/29 21:00")!
        return Tracklist(id: UUID(), decks: [Deck.mockDeck1(), Deck.mockDeck2(), Deck.mockDeck1(), Deck.mockDeck1()], name: "Silence 10", editedAt: date, bpm: 175, durationMinutes: 60)
    }
    
    static func mockTracklist2() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/12/24 16:00")!
        return Tracklist(id: UUID(), decks: [Deck.mockDeck1(), Deck.mockDeck2()], name: "Silence 11", editedAt: date, bpm: 174, durationMinutes: 45)
    }
}
