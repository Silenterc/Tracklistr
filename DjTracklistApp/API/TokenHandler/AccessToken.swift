//
//  AccessToken.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
// Represents an Access Token for Spotify API
struct AccessToken: Codable {
    let token: String
    let type: String
    let expireSec: Int
    
    enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case type = "token_type"
        case expireSec = "expires_in"
    }
}
