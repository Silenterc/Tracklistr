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
class DatabaseService {
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
            let descriptorTracklist = FetchDescriptor<Tracklist>(predicate: #Predicate<Tracklist> {
                tlist in tlist.id == id
            })
            
            let tracklists = try databaseContext.fetch(descriptorTracklist)
            if (tracklists.count > 1) {
                throw FetchError.moreThanOneItemFound
            } else if (tracklists.isEmpty) {
                throw FetchError.noItemsFound
            }
            let tracklist = tracklists.first!
         //   tracklist.players!.forEach({print($0.order)})
            return tracklist
        }
    }
    
    func fetchTracklists() throws -> [Tracklist] {
        let descriptor = FetchDescriptor<Tracklist>(sortBy: [SortDescriptor(\.editedAt)])
        return try databaseContext.fetch(descriptor)
    }
    /// Fetches all the players belonging to a tracklist in ascending order by their order variable
    /// - Parameter  id: id of the owning tracklist
    func fetchPlayers(id: UUID) throws -> [Player] {
        do {
            let descriptorPlayers = FetchDescriptor<Player>(predicate: #Predicate<Player> {
                pl in pl.tracklist?.id == id
            }, sortBy: [SortDescriptor(\Player.order)])
            
            let players = try databaseContext.fetch(descriptorPlayers)
            
            if (players.isEmpty) {
                throw FetchError.noItemsFound
            }
            
            return players
        }
        
        
        
        
        
    }
    /// Inserts a given tracklist into the db
    func insertTracklist(tracklist: Tracklist) {
        databaseContext.insert(tracklist)
    }
    func insertPlayer(player: Player) {
        databaseContext.insert(player)
    }
    func removeTrack(track: Track) {
        databaseContext.delete(track)
    }
    
    private func sortAll(tracklist: Tracklist) {
        tracklist.players!.sort(by: {$0.order < $1.order})
        for player in tracklist.players! {
            player.tracks!.sort(by: {$0.position < $1.position})
        }
    }
}
