//
//  TrackCellVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 24.01.2024.
//

import Foundation
import SwiftData
import SwiftUI
/// ViewModel for the TrackCell
@Observable
class TrackCellVM {
    var track: Track
    var editedWidth: CGFloat? = nil
    var width: CGFloat {
        if let editedWidth = editedWidth {
            return editedWidth
        } else {
            return GridHandler.shared.getWidthFromBars(bars: track.currentDuration!)
        }
    }
    var drag: CGSize = .zero
    var dragging: Bool = false
    var xOffset: CGFloat = 0
    
    init(track: Track) {
        self.track = track
     //   self.width = GridHandler.shared.getWidthFromBars(bars: track.currentDuration!)
    }
    
    func changeWidthRight(change: CGFloat) {
        let newWidth = width + change
        if newWidth <= GridHandler.shared.minimalWidth || newWidth <= 0 {
            return
        }
        let roundedNewWidth = GridHandler.shared.roundHorizontally(horizontalUnit: newWidth)
        let oldDurationBars = track.currentDuration!
        let newDurationBars = GridHandler.shared.getBarsFromWidth(width: roundedNewWidth)
        if newDurationBars > track.originalDurationBars {
            return
        }
        let change: Int = Int(newDurationBars) - Int(oldDurationBars)
        let oldEndTimeBars = track.endTimeBars!
        let newEndTimeBars = Int(oldEndTimeBars) + change
        
        track.endTimeBars! = UInt(newEndTimeBars)
        if GridHandler.shared.validatePosition(track: track, player: track.player!) {
            
            editedWidth = roundedNewWidth
        } else {
            track.endTimeBars = oldEndTimeBars
        }
    }
    
    func changeWidthLeft(change: CGFloat) {
        let newWidth = width + change
        if newWidth <= GridHandler.shared.minimalWidth {
            return
        }
        let roundedNewWidth = GridHandler.shared.roundHorizontally(horizontalUnit: newWidth)
        let oldDurationBars = track.currentDuration!
        let newDurationBars = GridHandler.shared.getBarsFromWidth(width: roundedNewWidth)
        
        let change: Int = Int(newDurationBars) - Int(oldDurationBars)
        let oldStartTimeBars = track.startTimeBars!
        let newStartTimeBars = Int(oldStartTimeBars) - change
        
        if newStartTimeBars < 0 {
            return
        }
        track.startTimeBars! = UInt(newStartTimeBars)
        let oldPosition = track.position
        track.position = track.position - (change > 0 ? GridHandler.shared.getWidthFromBars(bars: UInt(change)) : -1 * GridHandler.shared.getWidthFromBars(bars: UInt(abs(change))))
        if GridHandler.shared.validatePosition(track: track, player: track.player!) {
            editedWidth = roundedNewWidth
        } else {
            track.startTimeBars = oldStartTimeBars
            track.position = oldPosition
        }
    }
    
    func startOfDrag(start: CGPoint) {
        if !dragging {
            DragHandler.shared.draggedTrack = track
            xOffset = start.x - track.positionMiddle
            dragging.toggle()
        }
    }
    
    func endDrag() {
        drag = .zero
        dragging = false
        xOffset = 0
    }
    
    
}
