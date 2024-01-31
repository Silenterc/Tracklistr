//
//  NavigationViews.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 29.01.2024.
//

import Foundation
import SwiftUI
import SwiftData
/// Router allowing us to navigate throughout the app without having the Views responsible for it
/// Router pattern - https://www.curiousalgorithm.com/post/router-pattern-for-swiftui-navigation
class NavigationRouter: ObservableObject {
    let modelContext: ModelContext
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    /// The Views that our Router can navigate to, including their parameters
    enum Destination: Hashable {
        case mixOverview
        case tracklistInfoView(tracklistID: UUID? = nil)
        case tracklistView(tracklistID: UUID)
        case addTrackView(player: Player?, bpm: Float)
        case trackDetailView(track: Track?, player: Player?, bpm: Float?)
    }
    
    /// Path which is used to navigate the Stack programatically
    @Published var path: NavigationPath = NavigationPath()
    
    /// Used to construct the Views corresponding to their Destination
    @ViewBuilder func defineViews(for destination: Destination) -> some View {
        switch destination {
        case .mixOverview:
            MixOverviewView(modelContext: modelContext)
        case .tracklistInfoView(let id):
            TracklistInfoView(modelContext: modelContext, tracklistID: id)
        case .tracklistView(let id):
            TracklistView(modelContext: modelContext, tracklistID: id)
        case .addTrackView(let player, let bpm):
            AddTrackView(player: player, bpm: bpm)
        case .trackDetailView(let track, let player, let bpm):
            TrackDetailView(track: track, player: player, bpm: bpm)
        }

    }
    
    /// Navigates to a given View
    /// - Parameter destination: The View Destination to be navigated to
    func navigateTo(destination: Destination) {
        path.append(destination)
    }
    
    /// Navigates back N Views by popping N Views from the Stack
    /// - Parameter n: How many views back do I want to go
    func navigateNBack(n: Int) {
        path.removeLast(n)
    }
    
    /// Navigates to the root view by popping all views in the stack
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
