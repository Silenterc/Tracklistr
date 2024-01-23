//
//  TracklistViewVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import Foundation
import SwiftData

@Observable
class TracklistVM {
    
    // Middle man between our VM and SwiftData, used for all Database operations
    var databaseContext: ModelContext
    var tracklist: Tracklist
    
    init(databaseContext: ModelContext, tracklist: Tracklist) {
        self.databaseContext = databaseContext
        self.tracklist = tracklist
    }
    
    
    
    
    
}
