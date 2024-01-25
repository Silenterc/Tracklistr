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
    var tracklistID: UUID
    var tracklist: Tracklist?
    
    init(databaseContext: ModelContext, tracklistID: UUID) {
        self.databaseContext = databaseContext
        self.tracklistID = tracklistID
        fetchTracklist()
    }
    
    func fetchTracklist() {
        do {
            let descriptor = FetchDescriptor<Tracklist>(predicate: #Predicate<Tracklist> {
                tlist in tlist.id == tracklistID
            })
            
            tracklist = try databaseContext.fetch(descriptor)[0]
        } catch {
            fatalError("Fetch Failed")
        }
    }
    
    
}
