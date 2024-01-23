//
//  TimelineView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI

struct TimelineView: View {
    var spacing: CGFloat = 8
    @State var bars: Int
    
    var sixteenBars: Int {
        bars/16
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< sixteenBars, id: \.self){_ in
                makeSixteenBars()
            }
        }
    }
    
    private func makeSixteenBars() -> some View {
        HStack {
            makeIndicator(height: 28)
            makeIndicator(height: 14)
            makeIndicator(height: 14)
            makeIndicator(height: 14)
        }
    }
    private func makeIndicator(height: CGFloat) -> some View {
        Rectangle()
            .fill(.orange)
            .frame(width: 1, height: height)
    }
}

#Preview {
    TimelineView(bars: 60.getBars(bpm: 174, timeUnit: .minutes)) // Hour
}
