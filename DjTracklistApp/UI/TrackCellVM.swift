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
        let newEndTimeBars = Int(track.endTimeBars!) + change
        
        track.endTimeBars! = UInt(newEndTimeBars)
        width = roundedNewWidth
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
        let newStartTimeBars = Int(track.startTimeBars!) - change
        
        if newStartTimeBars < 0 {
            return
        }
        track.startTimeBars! = UInt(newStartTimeBars)
        width = roundedNewWidth
    }
    
    
}
