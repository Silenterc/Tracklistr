//
//  Extensions.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 23.01.2024.
//

import Foundation


extension Int {
    enum TimeUnit {
        case milliseconds
        case seconds
        case minutes
    }
    func getBars(bpm: Double, timeUnit: TimeUnit, timeSignature: Int = 4) -> Int {
        
        switch (timeUnit) {
        case .milliseconds: return Int (Double(self) / ((60000.0/bpm) * Double(timeSignature)))
        case .seconds: return Int (Double(self) / ((60.0/bpm) * Double(timeSignature)))
        case .minutes: return Int (Double(self) / ((1.0/bpm) * Double(timeSignature)))
        }
        
    }
}
