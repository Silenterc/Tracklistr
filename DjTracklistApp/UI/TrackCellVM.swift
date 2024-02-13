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
    
    func changeWidth(change: CGFloat) {
        let newWidth = width + change
        width = newWidth >= 0 ? newWidth : 0
    }
    
    
}
