//
//  Track.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation

struct Track: Codable, Identifiable {
    let id: String
    let name: String
    let duration_ms: Int
    let preview_url: String?
    let artists: [Artist]
    let album: Album
    var audioFeatures: AudioFeatures?
}

struct AudioFeatures: Codable, Identifiable {
    let id: String
    let energy: Float
    let key: Int
    let bpm: Float
    
    enum CodingKeys : String, CodingKey {
        case id, energy, key
        case bpm = "tempo"
        
    }
}
