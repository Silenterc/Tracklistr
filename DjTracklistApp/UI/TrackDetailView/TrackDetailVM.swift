//
//  TrackDetailVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 29.01.2024.
//

import Foundation

@Observable
class TrackDetailVM {
    var track: Track?
    var player: Player?
    var requiredBpm: Float?
    
    var name: String
    var artistNames: String
    var durationSeconds: UInt
    var durationMinutes: UInt
    var bpm: Float?
    // Where in the original song does the first bar happen, does not have to be 00:00 - can be offset by a few seconds
    var startTimeOffsetSeconds: Float = 0.0
    
    var errorShown: Bool = false
    var currentError: TrackInfoError?
    
    var currentStartTimeBars: UInt = 0
    var currentDurationBars: UInt = 64
    
    var showAdvancedOptions: Bool = false
    init(track: Track?, player: Player?, bpm: Float?) {
        self.track = track
        self.player = player
        self.requiredBpm = bpm
        self.name = track?.name ?? ""
        self.artistNames = track?.artistNames.joined(separator: ",") ?? ""
        let durSec = ((track?.originalDuration ?? 0) / 1000) % 60
        let durMin = ((track?.originalDuration ?? 0) / 1000) / 60
        self.durationSeconds = durSec
        self.durationMinutes = durMin
        self.bpm = track?.bpm
    }
    
    func createTrack() -> Bool {
        if validateTrack() {
            if let track = track {
                track.name = name
                track.artistNames = artistNames.components(separatedBy: ",")
                // In ms, and removed the starting offset because it is irrelevant for the duration
                // However the required bpm by the playlist can be different from the track's, so we have to scale it
                let unscaledOriginalDuration = ((durationSeconds + durationMinutes * 60) * 1000) - UInt(startTimeOffsetSeconds * 1000)
                // We scale it here
                let scaledOriginalDuration = UInt((Double(unscaledOriginalDuration) / Double(requiredBpm!)) * Double(bpm!))
                track.originalDuration = scaledOriginalDuration
                track.bpm = requiredBpm
                
                track.startTimeBars = currentStartTimeBars
                track.endTimeBars = currentStartTimeBars + currentDurationBars
                
                if let player = player, let tracks = player.tracks {
                    if tracks.contains(where: {$0.id == track.id }) {
                        return true
                    
                    } else {
                        var lastPos: CGFloat = 0
                        tracks.forEach { tr in
                            if tr.position >= lastPos {
                                lastPos = tr.positionRightEdge
                            }
                        }
                        track.position = lastPos
                        track.player = player
                        self.player!.tracks!.append(track)
                        return true
                    }
                }
                return false
                
                
                
            }
            
            
            
        }
        return false
    }
    
    
    func validateTrack() -> Bool {
        if let bpm = bpm {
            if bpm <= 0 {
                return showError(error: .negativeBpm)
            } else if name.isEmpty || artistNames.isEmpty {
                return showError(error: .missingData)
            } else if durationSeconds > 59 {
                return showError(error: .tooManySeconds)
            } else {
                
                let totalDurationSeconds = durationSeconds + durationMinutes * 60
                let totalDurationBars = totalDurationSeconds.getBars(bpm: bpm, timeUnit: .seconds)
                if (totalDurationBars < UIConstants.shared.track.minimumBars) {
                    return showError(error: .tooShortTrack)
                } else if startTimeOffsetSeconds < 0 {
                    return showError(error: .negativeOffset)
                } else if Double(totalDurationSeconds) - Double(startTimeOffsetSeconds) < UIConstants.shared.track.minimumBars.getTime(bpm: bpm, timeUnit: .seconds) {
                    return showError(error: .tooLongOffset)
                } else if currentStartTimeBars % 4 != 0 {
                    return showError(error: .barsNotDivisibleBy4)
                } else if totalDurationBars < UIConstants.shared.track.minimumBars + currentStartTimeBars {
                    return showError(error: .tooShortDuration)
                } else if currentDurationBars % 4 != 0 {
                    return showError(error: .barsNotDivisibleBy4)
                } else if currentDurationBars < UIConstants.shared.track.minimumBars {
                    return showError(error: .tooShortDuration)
                } else if currentStartTimeBars + currentDurationBars > totalDurationBars {
                    return showError(error: .tooLongDuration)
                }
                
                return true
                
            }
            
        } else {
            return showError(error: .missingData)
        }
    }
    
    func showError(error: TrackInfoError) -> Bool {
        currentError = error
        errorShown = true
        return false
    }
}
