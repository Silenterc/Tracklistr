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
    var tracklistSize: CGSize?
    var players: [Player]?
    /// Calculates where the track was dropped -> On which Player and in what location inside of it
    /// and either completes the drop including all the related operations or declines the drop
    /// - Parameter location Where has the user dropped the track in the "players" coordinateSpace
    ///  - Returns whether the drop could be performed at the desired location
    func performDrop(location: CGPoint) -> Bool {
        if let dragged = draggedTrack, let _ = tracklistSize, let _ = players {
            let player = getCorrespondingPlayer(location: location)
            if let player = player {
                if (GridHandler.shared.validatePositionCenter(track: dragged, player: player, centralCoord: location.x)) {
                    let leadingEdgePos = location.x - dragged.width / 2
                    let roundedPosition = GridHandler.shared.roundHorizontally(horizontalUnit: leadingEdgePos)
                    if roundedPosition < 0 {
                        return false
                    }
                    if (dragged.player?.id == player.id) {
                        dragged.position = roundedPosition
                        return true
                    } else {
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
        let trackHeight = UIConstants.Track.height
        let indicatorHeight = UIConstants.Indicator.Big.height
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
