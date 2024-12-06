//
//  GridHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 13.02.2024.
//

import Foundation
/// Class responsible for operations regarding calculating widths, positions, sizes of the track cells on the track timeline,
/// so they are able to snap to the timeline view -> almost like a grid
class GridHandler {
    /// Width of four bars, which is the smallest "width" unit in this app
    var fourBarsWidth: CGFloat { UIConstants.shared.indicator.width + UIConstants.shared.indicator.spacing}
    /// Width of just one bar
    private var barWidth: CGFloat {
        fourBarsWidth / 4
    }
    /// Singleton
    static let shared = GridHandler()
    /// The minimal width of a song should be equal to 16 bars song length
    var minimalWidth: CGFloat {
        getWidthFromBars(bars: 16)
    }
    /// Calculates the width that corresponds to bars
    /// - Parameter bars The amount of bars for which the width should be calculated
    func getWidthFromBars(bars: UInt) -> CGFloat {
        let fourBars = bars / 4
        return CGFloat(fourBars) * fourBarsWidth
        
    }
    /// Calculates the bars that correspond to width
    /// - Parameter width The width for which the bars should be calculated
    func getBarsFromWidth(width: CGFloat) -> UInt {
        return UInt(width / (barWidth * 4)) * 4
    }
    /// Finds the nearest horizontal point to ``horizontalUnit``, which can be used in the app -> It is divisible by ``fourBarsWidth``, the smallest width unit
    /// So basically it rounds ``horizontalUnit`` to be divisible by``fourBarsWidth``
    /// - Parameter horizontalUnit The x coordinate to be rounded to the nearest fourBars
    func roundHorizontally(horizontalUnit: CGFloat) -> CGFloat {
        let remainder = horizontalUnit.truncatingRemainder(dividingBy: fourBarsWidth)
        if (remainder < fourBarsWidth / 2) {
            return horizontalUnit - remainder
            
        } else {
            return horizontalUnit - remainder + fourBarsWidth
            
        }
    }
    /// Validates whether a track at ``leadingCoord`` doesnt overlap with another at a given ``player``.
    /// Before validating, it rounds the coordinates using ``roundHorizontally()``
    /// - Parameter leadingCoord: The current coordinates of the leading edge of the track
    func validatePosition(track: Track, player: Player, leadingCoord: CGFloat) -> Bool {
        let leadingRounded = roundHorizontally(horizontalUnit: leadingCoord)
        if let tracklist = player.tracklist {
            let tracklistLengthBars = tracklist.durationMinutes.getBars(bpm: tracklist.bpm, timeUnit: .minutes)
            let tracklistLengthWidth = getWidthFromBars(bars: tracklistLengthBars)
            if (leadingRounded >= tracklistLengthWidth || leadingRounded < 0) {
                return false
            }
        }
        // The proposed position of the track's left edge
        let positionLeft = leadingRounded
        let positionRight = leadingRounded + track.width
        for secTrack in player.tracks! {
            if secTrack.id == track.id {
               continue
            }
            if positionLeft < secTrack.positionRightEdge && positionRight > secTrack.position {
                return false
            }
        }
        return true
    }
    
    
}
