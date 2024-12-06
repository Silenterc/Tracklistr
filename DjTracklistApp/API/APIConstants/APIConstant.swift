//
//  APIConstant.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
/// Represents certain resource constants like urls for songs, tokens...
protocol APIConstant {
    static var baseURL: URL { get }
}
/// A way to store and manage API URLs
/// Inspired by https://medium.com/@hdmdhr/smartly-organize-api-endpoints-in-swift-433d7386d883
enum APIConstants {
    /// Constants for the Spotify API
    enum Spotify: RawRepresentable, APIConstant {
        static let baseURL = URL(string: "https://api.spotify.com/v1")!
        static let tokenURL = URL(string: "https://accounts.spotify.com/api/token")!
        static let contentType = "application/x-www-form-urlencoded"
        case searchTracks
        case searchTrack(id: String)
        case audioFeatures(id: String)
        // To conform to the RawRepresentable protocol, because with it the code is prettier
        var rawValue: String {
            switch self {
            case .searchTracks: return "search"
            case .searchTrack(let id): return "tracks/\(id)"
            case .audioFeatures(let id): return "audio-features/\(id)"
            }
        }
    }
    
    /// Constants for the Music API
    enum MusicAPI: RawRepresentable, APIConstant {
        static let baseURL = URL(string: "https://api.musicapi.com")!
        static let publicURL = URL(string: "https://api.musicapi.com/public")!
        // The sources in which the music API should search the track
        static let sources = ["soundCloud", "appleMusic", "tidal", "youtube", "boomplay", "deezer"]
        case searchTracks
        
        // To conform to the RawRepresentable protocol, because with it the code is prettier
        var rawValue: String {
            switch self {
            case .searchTracks: return "public/search"
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
