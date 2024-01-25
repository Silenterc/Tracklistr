//
//  TrackCellVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 24.01.2024.
//

import Foundation
import SwiftData

@Observable
class TrackCellVM {
    var track: AppTrack
    var width: CGFloat
    var height: CGFloat
    
    init(track: AppTrack, width: CGFloat, height: CGFloat) {
        self.track = track
        self.width = width
        self.height = height
    }
    
    func changeWidth(change: CGFloat) {
        let newWidth = width + change
        width = newWidth >= 0 ? newWidth : 0
    }
    
    
}
