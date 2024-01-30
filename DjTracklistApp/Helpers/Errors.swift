//
//  Errors.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 30.01.2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case accessKeyFailure
}

enum TrackInfoError: Error {
    case negativeBpm
    
}
