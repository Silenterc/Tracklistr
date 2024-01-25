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

extension Int {
    /// Returns the amount of bars that self is as the given time unit
    /// - Parameter bpm: Beats Per Minute - for what bpm should the bars be calculated
    /// - Parameter timeUnit: The unit of time that self represents
    ///  - Parameter timeSignature: The time signature for which the bars amount should be calculated, is 4 in most songs -> 4 beats in a bar
    func getBars(bpm: Double, timeUnit: TimeUnit, timeSignature: Int = 4) -> Int {
        // Bars get calculated with the formula: Bars = (AmountOfMinutes * Beats Per Minute)/Time Signature
        switch (timeUnit) {
        case .milliseconds: return Int((Double(self) * bpm) / (Double(timeSignature) * 60000.0))
        case .seconds: return Int((Double(self) * bpm) / (Double(timeSignature) * 60.0))
        case .minutes: return Int((Double(self) * bpm) / Double(timeSignature))
        }
        
    }
}
