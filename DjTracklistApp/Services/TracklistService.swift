//
//  TracklistService.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 25.01.2024.
//

import Foundation
import SwiftData

enum FetchError: Error {
    case noItemsFound
    case modeThanOneItemFound
}

class TracklistService {
    var databaseContext: ModelContext
    
    init(databaseContext: ModelContext) {
        self.databaseContext = databaseContext
    }
    
    
    func fetchTracklist(id: UUID) throws -> Tracklist {
        do {
            let descriptor = FetchDescriptor<Tracklist>(predicate: #Predicate<Tracklist> {
                tlist in tlist.id == id
            })
            
            let tracklists = try databaseContext.fetch(descriptor)
            if (tracklists.count > 1) {
                throw FetchError.modeThanOneItemFound
            } else if (tracklists.isEmpty) {
                throw FetchError.noItemsFound
            }
            return tracklists.first!
        }
    }
    
    func insertTracklist(tracklist: Tracklist) {
        databaseContext.insert(tracklist)
    }
    
    
    
    
    
    
}
