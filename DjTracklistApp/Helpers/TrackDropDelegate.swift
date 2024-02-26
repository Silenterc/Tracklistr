//
//  TrackDropDelegate.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 24.02.2024.
//

import Foundation
import SwiftUI

struct TrackDropDelegate : DropDelegate {
    @Binding var dragged: Track?
    var destPlayer: Player
    @Binding var srcPlayer: Player?
    @Binding var draggedPos: CGPoint?
    @Binding var playerSize: CGSize?
    
    func performDrop(info: DropInfo) -> Bool {
        print("\(dragged?.name ?? "")   \(srcPlayer?.order ?? -1)  -> \(destPlayer.order)")
        return true
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        let playerOrder = destPlayer.order
        draggedPos = CGPoint(x: info.location.x, y: info.location.y + CGFloat(playerOrder) * (playerSize?.height ?? 0))
        print(draggedPos?.y)
        if let track = dragged {
            if (GridHandler.shared.validatePositionCenter(track: track, player: destPlayer, centralCoord: info.location.x)) {
                return DropProposal(operation: .move)
            }
            return DropProposal(operation: .forbidden)
        }
        return DropProposal(operation: .forbidden)
    }
    
    
}
