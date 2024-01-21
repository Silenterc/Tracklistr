//
//  Album.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation

struct Album: Codable {
    let id: String
    let name: String
    let images: [Image]

    struct Image: Codable {
        let url: URL
        let height: Int
        let width: Int
    }
}
