//
//  Playlist.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation
import SwiftData
/// Class representing a tracklist
@Model
class Tracklist {
    @Attribute(.unique) let id: UUID
    /// The players that are present for this tracklist, will be usually 4
    @Relationship(deleteRule: .cascade, inverse: \Player.tracklist) var players: [Player]?
    /// Name of the Tracklist
    var name: String
    /// When was it last edited
    var editedAt: Date
    /// The Beats Per Minute of the tracklist, all the songs in the tracklist will need to have the same BPM
    var bpm: Float
    /// The duration of the whole tracklist, in minutes
    var durationMinutes: UInt
    
    init(id: UUID, players: [Player]? = [], name: String, editedAt: Date, bpm: Float, durationMinutes: UInt) {
        self.id = id
        self.players = players
        self.name = name
        self.editedAt = editedAt
        self.bpm = bpm
        self.durationMinutes = durationMinutes
    }
   
    
}

extension Tracklist {
    static func mockTracklist1() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/11/29 21:00")!
        return Tracklist(id: UUID(), players: [], name: "Silence 10", editedAt: date, bpm: 175, durationMinutes: 60)
    }
    
    static func mockTracklist2() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/12/24 16:00")!
        return Tracklist(id: UUID(), players: [Player.mockPlayer1(), Player.mockPlayer2()], name: "Silence 11", editedAt: date, bpm: 174, durationMinutes: 45)
    }
}
