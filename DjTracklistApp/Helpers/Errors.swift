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

enum TrackInfoError: String, LocalizedError {
    case missingData = "Missing Required Data"
    case negativeBpm = "Negative BPM"
    case tooManySeconds = "Too Many Seconds in the seconds field"
    case tooShortTrack = "Too Short Track (minimum is 16 bars)"
    case negativeOffset = "Negative Offset"
    case tooLongOffset = "Too Long Offset"
    case barsNotDivisibleBy4 = "Bars Not Divisible By 4"
    case tooShortDuration = "Too Short Duration (minimum is 16 bars)"
    case tooLongDuration = "Too Long Duration"
}
