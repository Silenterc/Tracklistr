//
//  TrackDetailVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 29.01.2024.
//

import Foundation

@Observable
class TrackDetailVM {
    var track: Track
    var player: Player
    
    var name: String
    var artistNames: String
    var durationSeconds: Int
    var durationMinutes: Int
    var bpm: Float?
    // Where in the original song does the first bar happen, does not have to be 00:00 - can be offset by a few seconds
    var startTimeOffsetSeconds: Float = 0.0
    
    
    var currentStartTimeBars: Int?
    var currentDurationBars: Int?
    init(track: Track, player: Player) {
        self.track = track
        self.player = player
        self.name = track.name
        self.artistNames = track.artistNames.joined(separator: ",")
        let durSec = (track.originalDuration / 1000) % 60
        let durMin = (track.originalDuration / 1000) / 60
        self.durationSeconds = durSec
        self.durationMinutes = durMin
        self.bpm = track.bpm
    }
    
    func createTrack() -> Bool {
        true
//        if bpm? <= 0 {
//            
//        } else if
        
        
        
        
        
        
    }
}
