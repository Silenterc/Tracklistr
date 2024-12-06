//
//  MusicApiService.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.02.2024.
//

import Foundation
/// Data Service responsible for the logic behind getting data from the API and manipulating it
class MusicApiService: ApiService {
    private let apiHandler: MusicAPIHandler
        
    init(apiHandler: MusicAPIHandler) {
        self.apiHandler = apiHandler
    }
    func getTrackWithFeatures(id: String) async throws -> Track {
        // This method should not be called on MusicAPI
        throw APIError.requestFailed
    }
    
    func searchTracks(nameQuery: String, artistsQuery: String) async throws -> [Track] {
        let body: [String: Any] = ["track": nameQuery, "artist": artistsQuery, "type": SearchType.track.rawValue, "sources": APIConstants.MusicAPI.sources]
        let dataBody: Data = try JSONSerialization.data(withJSONObject: body)
        
        let result: MusicApiSearchResult = try await apiHandler.request(url: APIConstants.MusicAPI.searchTracks.url, body: dataBody)
        
        return extractTracks(orig: result.tracks)
        
    }
    
    private func extractTracks(orig: [WrappedMusicApiTrack]) -> [Track] {
        var tracks: [Track] = []
        orig.forEach { tr in
            // The request was successful and we got some track
            if let extracted = tr.track {
                let convTrack = Track(musiTrack: extracted)
                tracks.append(convTrack)
            }
        }
        return tracks
    }
    
    
}
