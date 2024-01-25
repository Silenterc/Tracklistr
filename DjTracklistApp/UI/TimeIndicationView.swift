//
//  TimelineView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI

struct TimeIndicationView: View {
    var spacing: CGFloat = 8
    @State var bars: Int
    
    var sixteenBars: Int {
        bars/16
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<sixteenBars, id: \.self) {_ in
                makeSixteenBars()
                    
            }
            Spacer()
        }
        .frame(height: 28)
        .frame(maxWidth: .infinity)
    }
    
    private func makeSixteenBars() -> some View {
        HStack(spacing: UIConstants.Indicator.spacing) {
            makeIndicator(height: UIConstants.Indicator.Big.height)
            makeIndicator(height: UIConstants.Indicator.Small.height)
            makeIndicator(height: UIConstants.Indicator.Small.height)
            makeIndicator(height: UIConstants.Indicator.Small.height)
        }
        .frame(width: 32, alignment: Alignment.leading)
    }
    private func makeIndicator(height: CGFloat) -> some View {
        Rectangle()
            .fill(.timelineIndicator)
            .frame(width: UIConstants.Indicator.width, height: height)
    }
}

#Preview {
    TimeIndicationView(bars: 60.getBars(bpm: 174, timeUnit: .minutes)) // Hour
}
