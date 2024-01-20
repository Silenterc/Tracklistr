//
//  ContentView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var track: Track?

        var body: some View {
            VStack {
                if let track = track {
                    Text("Track Name: \(track.name)")
                        .padding()
                } else {
                    Text("Loading...")
                        .padding()
                        .onAppear {
                            Task {
                                do {
                                    track = try await SpotifyAPIHandler.shared.request(url: APIConstants.Spotify.searchTrack(id: "5sRnIWpoK4o28zdLf5mz1e").url)
                                    
                                } catch {
                                    print("Error: \(error)")
                                }
                            }
                        }
                }
            }
        }
}

#Preview {
    ContentView()
}
