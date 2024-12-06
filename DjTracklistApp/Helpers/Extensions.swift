//
//  Extensions.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import Foundation
import SwiftUI
/// Represents different time units used in the App
enum TimeUnit {
    case milliseconds
    case seconds
    case minutes
}

extension UInt {
    /// Returns the amount of bars that self is as the given time unit
    /// Bars get calculated with the formula: Bars = (AmountOfMinutes * Beats Per Minute)/Time Signature
    /// - Parameter bpm: Beats Per Minute - for what bpm should the bars be calculated
    /// - Parameter timeUnit: The unit of time that self represents
    ///  - Parameter timeSignature: The time signature for which the bars amount should be calculated, is 4 in most songs -> 4 beats in a bar
    func getBars(bpm: Float, timeUnit: TimeUnit, timeSignature: Int = 4) -> UInt {
        switch (timeUnit) {
        case .milliseconds: return UInt((Double(self) * Double(bpm)) / (Double(timeSignature) * 60000.0))
        case .seconds: return UInt((Double(self) * Double(bpm)) / (Double(timeSignature) * 60.0))
        case .minutes: return UInt((Double(self) * Double(bpm)) / Double(timeSignature))
        }
        
    }
    /// Returns the amount of time that self is as the given amount of bars
    /// Time gets calculated with the formula: AmountOfMinutes = (Bars * Time Signature)/Beats Per Minute
    /// - Parameter bpm: Beats Per Minute - for what bpm should the time amount be calculated
    /// - Parameter timeUnit: The unit of time that we want to calculate from self
    ///  - Parameter timeSignature: The time signature for which the time amount should be calculated, is 4 in most songs -> 4 beats in a bar
    func getTime(bpm: Float, timeUnit: TimeUnit, timeSignature: Int = 4) -> Double {
        switch (timeUnit) {
        case .milliseconds: return (Double(self) * 60000.0 * Double(timeSignature)) / Double(bpm)
        case .seconds: return (Double(self) * 60.0 * Double(timeSignature)) / Double(bpm)
        case .minutes: return (Double(self) * Double(timeSignature)) / Double(bpm)
        }
        
    }
}

extension View {
    func useSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background (
            GeometryReader { geometry in
                Color.clear
                    .preference(key: GeoSizePrefKey.self, value: geometry.size)
                    .onPreferenceChange(GeoSizePrefKey.self, perform: onChange)
            }
        )
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct GeoSizePrefKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
    

