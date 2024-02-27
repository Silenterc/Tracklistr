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
final class Track: Identifiable {
    
    @Attribute(.unique) let id:UUID
    /// Id of this track from the API it was taken from , is empty for custom song
    let externalId: String
    /// Name of the track
    var name: String
    /// Artist names for the track
    var artistNames: [String]
    /// Name of the album that this track belongs to
    var albumName: String
    /// URL with the cover art image
    let imageUrl: URL?
    /// The full duration of the song in milliseconds
    var originalDuration: UInt
    /// The full duration of the song in bars
    var originalDurationBars: UInt {
        originalDuration.getBars(bpm: bpm!, timeUnit: .milliseconds)
    }
    /// Beats Per Minute of the song
    var bpm: Float?
    /// Specific point in the duration of the track, where it should start from
    /// f.e.: I want to play the track already 16 bars in, not from the start
    var startTimeBars: UInt? = 0
    /// Specific point in the duration of the track, where it should end at
    /// f.e.: I want to stop playing the track 64 bars in, not at the end
    var endTimeBars: UInt? = 0
    /// Current duration of the track in bars
    var currentDuration: UInt? {
        if let start = startTimeBars {
            if let end = endTimeBars {
               return end - start
            }
        }
        return nil
    }
    /// The position of the track in the Player View. Right now it refers to the position of the left edge from the left,
    /// because the offset is performed by .padding().
    var position: CGFloat = 0
    
    var positionRightEdge: CGFloat {
        if let dur = currentDuration {
            return position + GridHandler.shared.getWidthFromBars(bars: dur)
        } else {
            return 0
        }
    }
    
    var positionMiddle: CGFloat {
        position + width / 2
    }
    var width: CGFloat {
        positionRightEdge - position
    }
    /// The player to which this track belongs to
    var player: Player?
    
    init(id: UUID, externalId: String, name: String, artistNames: [String], albumName: String, imageUrl: URL? = nil, originalDuration: UInt, bpm: Float?, startTimeBars: UInt? = nil, endTimeBars: UInt? = nil, position: CGFloat = 0, player: Player? = nil) {
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
        self.position = position
        self.player = player
    }
    
    init(spotTrack: SpotifyTrack) {
        self.id = UUID()
        self.externalId = spotTrack.id
        self.name = spotTrack.name
        self.artistNames = spotTrack.artists.map{$0.name}
        self.albumName = spotTrack.album.name
        self.imageUrl = spotTrack.album.images.first?.url
        self.originalDuration = UInt(spotTrack.duration_ms)
        self.bpm = spotTrack.audioFeatures?.bpm
    }
    
    init(musiTrack: MusicApiTrack) {
        self.id = UUID()
        self.externalId = musiTrack.externalId
        self.name = musiTrack.name
        self.artistNames = musiTrack.artistNames ?? []
        self.albumName = musiTrack.albumName ?? ""
        self.imageUrl = musiTrack.imageUrl
        self.originalDuration = UInt(musiTrack.duration ?? 0)
    }
    
}

extension Track {
    static func mockSolarSystemTrack() -> Track {
        return Track(
            id: UUID(),
            externalId: "solar_system_sub_focus",
            name: "Solar System",
            artistNames: ["Sub Focus"],
            albumName: "Solar System",
            imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b273e629cab6558cb496b60e2178")!,
            originalDuration: 288000,
            bpm: 174,
            startTimeBars: 0,
            endTimeBars: 96,
            position: 0
        )
    }
    
    static func mockDevotionTrack() -> Track {
        return Track(
            id: UUID(),
            externalId: "devotion",
            name: "Devotion",
            artistNames: ["Dimension", "Cameron Haynes"],
            albumName: "Devotion",
            imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b273a5903731fb2c73f61a99bd4a")!,
            originalDuration: 190000,
            bpm: 174,
            startTimeBars: 0,
            endTimeBars: 96,
            position: GridHandler.shared.getWidthFromBars(bars: 96)
        )
    }
    
    static func mockFallingTrack() -> Track {
        return Track(
            id: UUID(),
            externalId: "falling",
            name: "Falling",
            artistNames: ["Camo & Krooked"],
            albumName: "Falling",
            imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b27355a0011a809339d416ceec67")!,
            originalDuration: 198857,
            bpm: 174,
            startTimeBars: 0,
            endTimeBars: 96,
            position: GridHandler.shared.getWidthFromBars(bars: 96 * 2)
        )
    }
    
    static func mockDesireTrack() -> Track {
        return Track(
            id: UUID(),
            externalId: "desire",
            name: "Desire",
            artistNames: ["Sub Focus, Dimension"],
            albumName: "Desire",
            imageUrl: URL(string: "https://i.scdn.co/image/ab67616d0000b273b393fcf525ae1aea04eb9b5a")!,
            originalDuration: 242758,
            bpm: 174,
            startTimeBars: 0,
            endTimeBars: 96,
            position: GridHandler.shared.getWidthFromBars(bars: 96 * 3)
        )
    }
}
