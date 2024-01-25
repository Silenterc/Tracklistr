//
//  MixOverviewVM.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation
import SwiftData
/**
 ViewModel for the MixOverview View.
 */
@Observable
class MixOverviewVM {
    // Array of the tracklists the user has created so far
    var tracklists: [Tracklist] = []
    // Middle man between our VM and SwiftData, used for all Database operations
    var databaseContext: ModelContext
    
    init(databaseContext: ModelContext, tracklists: [Tracklist] = []) {
        self.tracklists = tracklists
        self.databaseContext = databaseContext
        fetchTracklists()
   
    }
    
    func fetchTracklists() {
        do {
            let descriptor = FetchDescriptor<Tracklist>(sortBy: [SortDescriptor(\.editedAt)])
            tracklists = try databaseContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    func insertTracklist(tracklist: Tracklist) {
        databaseContext.insert(tracklist)
    }
}
