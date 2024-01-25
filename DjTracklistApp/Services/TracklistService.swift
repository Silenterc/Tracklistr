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
    case moreThanOneItemFound
}
/// A higher level abstraction around workign with SwiftData's modelContext
/// Used for accessing Tracklist data in the db
/// Similar to the repository design pattern
class TracklistService {
    /// The SwiftData model Context used in this App, is used as the entrypoint to the db
    var databaseContext: ModelContext
    
    init(databaseContext: ModelContext) {
        self.databaseContext = databaseContext
    }
    
    /// Fetches a tracklist by it's id
    /// - Parameter id: id of the tracklist to be fetched
    /// - Throws `FetchError.noItemsFound` if there are no Tracklists with the given ID
    /// - Throws `FetchError.moreThanOneItemFound` if there were more than one Tracklist with the same ID (should not happen ever)
    func fetchTracklist(id: UUID) throws -> Tracklist {
        do {
            let descriptor = FetchDescriptor<Tracklist>(predicate: #Predicate<Tracklist> {
                tlist in tlist.id == id
            })
            
            let tracklists = try databaseContext.fetch(descriptor)
            if (tracklists.count > 1) {
                throw FetchError.moreThanOneItemFound
            } else if (tracklists.isEmpty) {
                throw FetchError.noItemsFound
            }
            return tracklists.first!
        }
    }
    /// Inserts a given tracklist into the db
    func insertTracklist(tracklist: Tracklist) {
        databaseContext.insert(tracklist)
    }
    
    
    
    
    
    
}
