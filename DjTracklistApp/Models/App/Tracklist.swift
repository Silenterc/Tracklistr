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
    @Relationship(deleteRule: .cascade) var tracks: [AppTrack]
    var name: String
    var editedAt: Date
    
    init(id: UUID, tracks: [AppTrack], name: String, editedAt: Date) {
        self.id = id
        self.tracks = tracks
        self.name = name
        self.editedAt = editedAt
    }
    
}

extension Tracklist {
    static func mockTracklist1() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/11/29 21:00")!
        return Tracklist(id: UUID(), tracks: [], name: "Silence 10", editedAt: date)
    }
    
    static func mockTracklist2() -> Tracklist {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = formatter.date(from: "2023/12/24 16:00")!
        return Tracklist(id: UUID(), tracks: [], name: "Silence 11", editedAt: date)
    }
}
