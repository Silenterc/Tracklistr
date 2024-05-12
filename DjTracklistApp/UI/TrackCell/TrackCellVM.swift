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
    var draggingLeft: Bool = false
    var draggingRight: Bool = false
    var xOffset: CGFloat = 0
    var shorterUI: Bool {track.currentDuration! <= 48}
    init(track: Track) {
        self.track = track
       // self.width = GridHandler.shared.getWidthFromBars(bars: track.currentDuration!)
    }
    
    func changeWidthRight(change: CGFloat) {
        draggingRight = true
        let newWidth = width + change
        if newWidth <= GridHandler.shared.minimalWidth || newWidth <= 0 {
            return
        }
        let roundedNewWidth = GridHandler.shared.roundHorizontally(horizontalUnit: newWidth)
        let oldDurationBars = track.currentDuration!
        let newDurationBars = GridHandler.shared.getBarsFromWidth(width: roundedNewWidth)
        if (newDurationBars) > track.originalDurationBars {
            return
        }
        let change: Int = Int(newDurationBars) - Int(oldDurationBars)
        let oldEndTimeBars = track.endTimeBars!
        let newEndTimeBars = Int(oldEndTimeBars) + change
        if (newEndTimeBars > track.originalDuration.getBars(bpm: track.bpm!, timeUnit: .milliseconds)) {
            return
        }
        track.endTimeBars! = UInt(newEndTimeBars)
        if GridHandler.shared.validatePosition(track: track, player: track.player!, leadingCoord: track.position) {
            
            editedWidth = roundedNewWidth
        } else {
            track.endTimeBars = oldEndTimeBars
        }
    }
    
    func changeWidthLeft(change: CGFloat) {
        draggingLeft = true
        let newWidth = width + change
        if newWidth <= GridHandler.shared.minimalWidth {
            return
        }
        let roundedNewWidth = GridHandler.shared.roundHorizontally(horizontalUnit: newWidth)
        let oldDurationBars = track.currentDuration!
        let newDurationBars = GridHandler.shared.getBarsFromWidth(width: roundedNewWidth)
        
        let changeBars: Int = Int(newDurationBars) - Int(oldDurationBars)
        let oldStartTimeBars = track.startTimeBars!
        let newStartTimeBars = Int(oldStartTimeBars) - changeBars
        
        if newStartTimeBars < 0 {
            return
        }
        track.startTimeBars! = UInt(newStartTimeBars)
        let oldPosition = track.position
        track.position = track.position - (changeBars > 0 ? GridHandler.shared.getWidthFromBars(bars: UInt(changeBars)) : -1 * GridHandler.shared.getWidthFromBars(bars: UInt(abs(changeBars))))
        if GridHandler.shared.validatePosition(track: track, player: track.player!, leadingCoord: track.position) {
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
