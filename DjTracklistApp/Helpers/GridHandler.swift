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
    
    let fourBarsWidth: CGFloat = UIConstants.Indicator.width + UIConstants.Indicator.spacing
    
    private var barWidth: CGFloat {
        fourBarsWidth / 4
    }
    
    static let shared = GridHandler()
    
    var minimalWidth: CGFloat {
        getWidthFromBars(bars: 16)
    }
    func getWidthFromBars(bars: UInt) -> CGFloat {
        let fourBars = bars / 4
        return CGFloat(fourBars) * fourBarsWidth
        
    }
    func getBarsFromWidth(width: CGFloat) -> UInt {
        return UInt(width / barWidth)
    }
    
    func roundWidth(width: CGFloat) -> CGFloat {
        let remainder = width.truncatingRemainder(dividingBy: fourBarsWidth)
        if (remainder < fourBarsWidth / 2) {
            return width - remainder
            
        } else {
            return width - remainder + fourBarsWidth
            
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
    
    func validatePositionCenter(track: Track, player: Player, centralCoord: CGFloat) -> Bool {
        // The proposed position of the track's left edge
        let positionLeft = centralCoord - ((track.positionRightEdge - track.position) / 2)
        let positionRight = centralCoord + ((track.positionRightEdge - track.position) / 2)
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
