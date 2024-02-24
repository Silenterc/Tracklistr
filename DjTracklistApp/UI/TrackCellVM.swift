//
//  TrackCellVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 24.01.2024.
//

import Foundation
import SwiftData
/// ViewModel for the TrackCell
@Observable
class TrackCellVM {
    var track: Track
    var width: CGFloat = 0
    var height: CGFloat = UIConstants.Track.height
    
    init(track: Track) {
        self.track = track
        self.width = GridHandler.shared.getWidthFromBars(bars: track.currentDuration!)
    }
    
    func changeWidthRight(change: CGFloat) {
        let newWidth = width + change
        if newWidth <= GridHandler.shared.minimalWidth || newWidth <= 0 {
            return
        }
        let roundedNewWidth = GridHandler.shared.roundWidth(width: newWidth)
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
            
            width = roundedNewWidth
        } else {
            track.endTimeBars = oldEndTimeBars
        }
    }
    
    func changeWidthLeft(change: CGFloat) {
        let newWidth = width + change
        if newWidth <= GridHandler.shared.minimalWidth {
            return
        }
        let roundedNewWidth = GridHandler.shared.roundWidth(width: newWidth)
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
            width = roundedNewWidth
        } else {
            track.startTimeBars = oldStartTimeBars
            track.position = oldPosition
        }
    }
    
    
}
