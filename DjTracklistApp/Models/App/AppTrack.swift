//
//  AppTrack.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation
import SwiftData

@Model
final class AppTrack: Identifiable {
    @Attribute(.unique) let id:UUID
    let externalId: String
    let name: String
    let artistNames: [String]
    let albumName: String
    let imageUrl: URL
    let originalDuration: Int
    let bpm: Double?
    
    var startTimeBars: Int = 0
    var endTimeBars: Int = 0
    var currentDuration: Int {
        endTimeBars - startTimeBars
    }
    var deck: Deck?
    
    init(id: UUID, externalId: String, name: String, artistNames: [String], albumName: String, imageUrl: URL, originalDuration: Int, bpm: Double?, startTimeBars: Int, endTimeBars: Int, deck: Deck? = nil) {
        self.id = id
        self.externalId = externalId
        self.name = name
        self.artistNames = artistNames
        self.albumName = albumName
        self.imageUrl = imageUrl
        self.originalDuration = originalDuration
        self.bpm = bpm
        self.startTimeBars = startTimeBars
        self.endTimeBars = endTimeBars
        self.deck = deck
    }
}

extension AppTrack {
    static func mockSolarSystemTrack() -> AppTrack {
        return AppTrack(
            id: UUID(),
            externalId: "solar_system_sub_focus",
            name: "Solar System",
            artistNames: ["Sub Focus"],
            albumName: "Solar System",
            imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b273e629cab6558cb496b60e2178")!,
            originalDuration: 288000,
            bpm: 174,
            startTimeBars: 0,
            endTimeBars: 92
        )
    }
    
    static func mockDevotionTrack() -> AppTrack {
        return AppTrack(
            id: UUID(),
            externalId: "devotion",
            name: "Devotion",
            artistNames: ["Dimension", "Cameron Haynes"],
            albumName: "Devotion",
            imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b273a5903731fb2c73f61a99bd4a")!,
            originalDuration: 190000,
            bpm: 174,
            startTimeBars: 0,
            endTimeBars: 92
        )
    }
}
