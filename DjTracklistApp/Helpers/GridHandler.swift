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
        return UInt(width / barWidth)
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
    
    /// Validates whether the track doesnt overlap with another -> their positions and durations are not overlapping, so each track has its own place
    func validatePosition(track: Track, player: Player) -> Bool {
        for secTrack in player.tracks! {
            if secTrack.id == track.id {
                continue
            }
            if track.position < secTrack.positionRightEdge && track.positionRightEdge > secTrack.position {
                return false
            }
        }
        return true
    }
    /// Validates whether a track at ``centralCoord`` doesnt overlap with another at a given ``player``.
    /// Before validating, it rounds the coordinates using ``roundHorizontally()``
    /// - Parameter centralCoord: The current coordinates of the center of the track
    func validatePositionCenter(track: Track, player: Player, centralCoord: CGFloat) -> Bool {
        let rounded = roundHorizontally(horizontalUnit: centralCoord)
        // The proposed position of the track's left edge
        let positionLeft = rounded - (track.width / 2)
        let positionRight = rounded + (track.width / 2)
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
