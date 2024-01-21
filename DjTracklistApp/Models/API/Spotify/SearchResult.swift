//
//  SearchResult.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation

class SearchObject: Codable{
    let href: URL
    let limit: Int
    let next: URL?
    let offset: Int
    let previous: URL?
    let total: Int
}

class TracksObject : SearchObject {
    let items: [Track]
    
    enum CodingKeys: String, CodingKey {
            case items
    }
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.items = try container.decodeIfPresent([Track].self, forKey: .items) ?? []
            try super.init(from: decoder)
        }
}

class ArtistsObject : SearchObject {
    let items: [Artist]
    
    enum CodingKeys: String, CodingKey {
            case items
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decodeIfPresent([Artist].self, forKey: .items) ?? []
        try super.init(from: decoder)
    }
}

struct SearchResult: Codable {
    let tracks: TracksObject?
    let artists: ArtistsObject?
    
}

