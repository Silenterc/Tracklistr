//
//  AppTrack.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation


struct MusicApiTrack: Codable {
    let externalId: String
    let name: String
    let artistNames: [String]?
    let albumName: String?
    let imageUrl: URL?
    let duration: Int?
    
}

struct WrappedMusicApiTrack: Codable {
    let source: String
    let status: String
    let track: MusicApiTrack?
    let type: String
    enum CodingKeys: String, CodingKey {
        case source, status, type
        case track = "data"
    }
}

