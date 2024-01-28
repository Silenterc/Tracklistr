//
//  SpotifyService.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
/// Data Service responsible for the logic behind getting data from the API and manipulating it
class SpotifyService: ApiService {
    private let apiHandler: SpotifyAPIHandler
        
    init(apiHandler: SpotifyAPIHandler) {
        self.apiHandler = apiHandler
    }
    /// Fetches a Track by it's ID
    func getTrack(id: String) async throws -> SpotifyTrack {
        try await apiHandler.request(url: APIConstants.Spotify.searchTrack(id: id).url)
    }
    /// Fetches a Track with it's audioFeatures initialized
    func getTrackWithFeatures(id: String) async throws -> Track {
        var track = try await getTrack(id: id)
        let trackFeatures: AudioFeatures = try await apiHandler.request(url: APIConstants.Spotify.audioFeatures(id: id).url)
        track.audioFeatures = trackFeatures
        return Track(spotTrack: track)
        
    }
    /// Makes a search for tracks given a query
    func searchTracks(nameQuery: String,artistsQuery: String) async throws -> [Track] {
        let queryItems = [URLQueryItem(name: "q", value: nameQuery + " " + artistsQuery),
                          URLQueryItem(name: "type", value: SearchType.track.rawValue),
                          URLQueryItem(name: "limit", value: String(10))]
        // Handle returning only the [Track] because the API returns more info
        let searchResult: SearchResult = try await apiHandler.request(url: APIConstants.Spotify.searchTracks.url.appending(queryItems: queryItems))
        return searchResult.tracks?.items.map{Track.init(spotTrack: $0)} ?? []
    }
}

/// All the possible things to search for on the Spotify API
enum SearchType: String {
    case album
    case artist
    case playlist
    case track
    case show
    case episode
    case audiobook
}
