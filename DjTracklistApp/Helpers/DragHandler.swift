//
//  DragHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 27.02.2024.
//

import Foundation
/// Class responsible for the custom drag & drop functionality which is used in this app
class DragHandler {
    var draggedTrack: Track?
    var players: [Player]?
    /// Calculates where the track was dropped -> On which Player and in what location inside of it
    /// and either completes the drop including all the related operations or declines the drop
    /// - Parameter location Where has the user dropped the track in the "players" coordinateSpace. The location should be of the center of the dropped Track.
    ///  - Returns whether the drop could be performed at the desired location
    func performDrop(location: CGPoint) -> Bool {
        if let dragged = draggedTrack {
            // Calculates which Player is the location closest to
            let player = getCorrespondingPlayer(location: location)
            if let player = player {
                // Validate if there is enough space for the track at the location of the drop
                if (GridHandler.shared.validatePosition(track: dragged, player: player, leadingCoord: location.x - dragged.width / 2)) {
                    // Get the position of the leading edge of the track (since location represents the center)
                    let leadingEdgePos = location.x - dragged.width / 2
                    // Round it to the nearest four bars
                    let roundedPosition = GridHandler.shared.roundHorizontally(horizontalUnit: leadingEdgePos)
                    // If we dropped to the same player that we dragged from, we just change the track position
                    if (dragged.player?.id == player.id) {
                        dragged.position = roundedPosition
                        return true
                    } else {
                        // Move the track from one palyer to the other
                        dragged.player?.tracks?.removeAll(where: { tr in
                            tr.id == dragged.id
                        })
                        dragged.position = roundedPosition
                        player.tracks?.append(dragged)
                        dragged.player = player
           
                        return true
                   
                    }
                    
                }
                
                return false
                
            }
            return false
            
        } else {
            return false
        }
    }
    /// Returns the player that is at the location
    /// - Parameter location location at which to search for the player
    /// - Returns the corresponding palyer or nil if there isn't any Player
    private func getCorrespondingPlayer(location: CGPoint) -> Player? {
        if location.y < 0 {
            return nil
        }
        let trackHeight = UIConstants.shared.track.height
        let indicatorHeight = UIConstants.shared.indicator.big.height
        var lowerBound: CGFloat = 0
        for player in players! {
            lowerBound += trackHeight + indicatorHeight
            if location.y < lowerBound {
                return player
            }
        }
        return nil
    }
    static let shared = DragHandler()
    
    
    
    
}
