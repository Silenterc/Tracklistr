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
                }
            }
        }
}

#Preview {
    ContentView()
}
