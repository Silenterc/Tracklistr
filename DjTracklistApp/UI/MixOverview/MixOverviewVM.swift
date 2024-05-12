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
    var databaseService: DatabaseService
    
    var selectedTracklist: Tracklist?
    
    init(databaseService: DatabaseService, tracklists: [Tracklist] = []) {
        self.tracklists = tracklists
        self.databaseService = databaseService
        fetchTracklists()
    }
    
    func fetchTracklists() {
        do {
            tracklists = try databaseService.fetchTracklists()
        } catch {
            print("Fetch failed")
        }
    }
    
    func insertTracklist(tracklist: Tracklist) {
        databaseService.insertTracklist(tracklist: tracklist)
    }
    
    func deleteTracklist(indexSet: IndexSet) {
        for index in indexSet {
            databaseService.deleteTracklist(tracklist: tracklists[index])
        }
        fetchTracklists()
    }
}
