//
//  AppTrack.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation
import SwiftData

@Model
class AppTrack: Identifiable {
    @Attribute(.unique) let id:UUID
    let externalId: String
    let name: String
    let artistNames: [String]
    let albumName: String
    let imageUrl: URL
    let originalDuration: Int
    let bpm: Int?
    
    var currentDuration: Int
    var startTime: Int
    var endTime: Int
    var deck: Deck?
    
    init(id: UUID, externalId: String, name: String, artistNames: [String], albumName: String, imageUrl: URL, originalDuration: Int, bpm: Int?, currentDuration: Int, startTime: Int, endTime: Int, deck: Deck? = nil) {
        self.id = id
        self.externalId = externalId
        self.name = name
        self.artistNames = artistNames
        self.albumName = albumName
        self.imageUrl = imageUrl
        self.originalDuration = originalDuration
        self.bpm = bpm
        self.currentDuration = currentDuration
        self.startTime = startTime
        self.endTime = endTime
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
            originalDuration: 240,
            bpm: 174,
            currentDuration: 0,
            startTime: 0,
            endTime: 120
        )
    }
    
    static func mockSolarDevotionTrack() -> AppTrack {
        return AppTrack(
            id: UUID(),
            externalId: "solar_system_sub_focus",
            name: "Solar System",
            artistNames: ["Sub Focus"],
            albumName: "Solar System",
            imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b273e629cab6558cb496b60e2178")!,
            originalDuration: 240,
            bpm: 174,
            currentDuration: 0,
            startTime: 0,
            endTime: 120
        )
    }
}
