//
//  APIConstant.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
// Represents certain resource constants like urls for songs, tokens...
protocol APIConstant {
    static var baseURL: URL { get }
}

enum APIConstants {
    // Constants for the Spotify API
    enum Spotify: RawRepresentable, APIConstant {
        
        static let baseURL = URL(string: "https://api.spotify.com/v1")!
        static let tokenURL = URL(string: "https://accounts.spotify.com/api/token")!
        static let contentType = "application/x-www-form-urlencoded"
        case searchTracks
        case searchTrack(id: String)
        // To conform to the RawRepresentable protocol, because with it the code is prettier
        var rawValue: String {
            switch self {
            case .searchTracks: return "search"
            case .searchTrack(let id): return "tracks/\(id)"
            }
        }
    }
}

extension RawRepresentable where RawValue == String, Self: APIConstant {
    // Ability to easily get the URL of a given APIConstant
    var url: URL {
        Self.baseURL.appendingPathComponent(rawValue)
    }
    init?(rawValue: String) {
        nil
    }
}
