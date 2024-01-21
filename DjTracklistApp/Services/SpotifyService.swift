//
//  SpotifyService.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
// Data Service responsible for the logic behind getting data from the API and manipulating it
class SpotifyService {
    private let apiHandler: SpotifyAPIHandler
        
    init(apiHandler: SpotifyAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    func getTrack(id: String) async throws -> Track {
        try await apiHandler.request(url: APIConstants.Spotify.searchTrack(id: id).url)
    }
    
    func getTrackWithFeatures(id: String) async throws -> Track {
        var track = try await getTrack(id: id)
        let trackFeatures: AudioFeatures = try await apiHandler.request(url: APIConstants.Spotify.audioFeatures(id: id).url)
        track.audioFeatures = trackFeatures
        return track
        
    }
    
    func searchTracks(query: String, types: [SearchType] = [.track], limit: Int = 10) async throws -> [Track] {
        let typesString = types.map { $0.rawValue }.joined(separator: ",")
        let queryItems = [URLQueryItem(name: "q", value: query),
                          URLQueryItem(name: "type", value: typesString),
                          URLQueryItem(name: "limit", value: String(limit))]
        // Handle returning only the [Track] because the API returns more info
        let searchResult: SearchResult = try await apiHandler.request(url: APIConstants.Spotify.searchTracks.url.appending(queryItems: queryItems))
        return searchResult.tracks?.items ?? []
    }
}

enum SearchType: String {
    case album
    case artist
    case playlist
    case track
    case show
    case episode
    case audiobook
}
