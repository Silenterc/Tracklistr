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
    
    let currentDuration: Int
    let startTime: Int
    let endTime: Int
    let onDeck: Int
    
    init(id: UUID, externalId: String, name: String, artistNames: [String], albumName: String, imageUrl: URL, originalDuration: Int, bpm: Int?, currentDuration: Int, startTime: Int, endTime: Int, onDeck: Int) {
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
        self.onDeck = onDeck
    }
    
    
    
}
