//
//  TimelineView.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import SwiftUI
/// Simple view which creates the time indication, where the smallest unit is 4 Bars
struct TimeIndicationView: View {
    /// For how many bars should this View be generated
    @State var bars: UInt
    /// For how many phrases should this View be generated, where a phrase  is 16 Bars
    var sixteenBars: UInt {
        bars/16
    }
    
    var body: some View {
        LazyHStack(spacing: 0) {
            ForEach(0..<sixteenBars, id: \.self) {_ in
                makeSixteenBars()
            }
            // We want the indication to be aligned to the left, even if this view somehow gets stretched
            Spacer()
        }
        .frame(height: UIConstants.shared.indicator.big.height)
        .frame(maxWidth: .infinity)
    }
    /// Creates the visual representation of 16 Bars, which is made out of 4 Indicators -> 3 small and 1 big
    private func makeSixteenBars() -> some View {
        HStack(spacing: UIConstants.shared.indicator.spacing) {
            makeIndicator(height: UIConstants.shared.indicator.big.height)
            makeIndicator(height: UIConstants.shared.indicator.small.height)
            makeIndicator(height: UIConstants.shared.indicator.small.height)
            makeIndicator(height: UIConstants.shared.indicator.small.height)
        }
        .frame(width: GridHandler.shared.fourBarsWidth * 4, alignment: Alignment.leading)
    }
    /// Creates one Indicator
    ///  - Parameter height: Height of the Indicator
    private func makeIndicator(height: CGFloat) -> some View {
        Rectangle()
            .fill(.timelineIndicator)
            .frame(width: UIConstants.shared.indicator.width, height: height)
    }
}

#Preview {
    TimeIndicationView(bars: UInt(60).getBars(bpm: 174, timeUnit: .minutes)) // Hour
}
