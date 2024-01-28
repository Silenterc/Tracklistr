//
//  AppTrack.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation
import SwiftData
/// Class representing one track/song  in the App's tracklist
@Model
final class AppTrack: Identifiable {
    @Attribute(.unique) let id:UUID
    /// Id of this track from the API it was taken from , is empty for custom song
    let externalId: String
    /// Name of the track
    let name: String
    /// Artist names for the track
    let artistNames: [String]
    /// Name of the album that this track belongs to
    let albumName: String
    /// URL with the cover art image
    let imageUrl: URL
    /// The full duration of the song
    let originalDuration: Int
    /// Beats Per Minute of the song
    let bpm: Double?
    /// Specific point in the duration of the track, where it should start from
    /// f.e.: I want to play the track already 16 bars in, not from the start
    var startTimeBars: Int = 0
    /// Specific point in the duration of the track, where it should end at
    /// f.e.: I want to stop playing the track 64 bars in, not at the end
    var endTimeBars: Int = 0
    /// Current duration of the track
    var currentDuration: Int {
        endTimeBars - startTimeBars
    }
    /// The player to which this track belongs to
    var player: Player?
    
    init(id: UUID, externalId: String, name: String, artistNames: [String], albumName: String, imageUrl: URL, originalDuration: Int, bpm: Double?, startTimeBars: Int, endTimeBars: Int, player: Player? = nil) {
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
        self.player = player
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
