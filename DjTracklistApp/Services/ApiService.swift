//
//  ApiService.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 28.01.2024.
//

import Foundation

protocol ApiService {
    
    
    /// Fetches a Track with it's audioFeatures initialized
    func getTrackWithFeatures(id: String) async throws -> Track
    
    /// Makes a search for tracks given a query
    func searchTracks(nameQuery: String, artistsQuery: String) async throws -> [Track]
    
    
    
    
}
