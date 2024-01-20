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

    struct Artist: Codable {
        let id: String
        let name: String
    }

    struct Album: Codable {
        let id: String
        let name: String
        let images: [Image]

        struct Image: Codable {
            let url: String
            let height: Int
            let width: Int
        }
    }
}
