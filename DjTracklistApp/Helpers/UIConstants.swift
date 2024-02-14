//
//  UIConstants.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 24.01.2024.
//

import Foundation
/// Constants used throughout the APP, usually for UI purposes
enum UIConstants {
    /// Constants for the bar Indicators
    enum Indicator {
        static let spacing: CGFloat = 7
        static let width: CGFloat = 1
        enum Big {
            static let width: CGFloat = 1
            static let height: CGFloat = 28
        }
        
        enum Small {
            static let width: CGFloat = 1
            static let height: CGFloat = 14
            
        }
    }
    /// Fonts used in the App
    enum Font {
        static let regular = "Roboto-Regular"
        static let light = "Roboto-Light"
        static let bold = "Roboto-Bold"
        static let medium = "Roboto-Medium"
    }
    
    enum Track {
        static let height: CGFloat = 62
        static let minimumBars: UInt = 16
        static let nameSize: CGFloat = 12
        static let artistsSize: CGFloat = 8
        static let barsSize: CGFloat = 8
        static let timeSize: CGFloat = 8
        static let barSize: CGFloat = 8
        
        
        enum Image {
            static let width: CGFloat = 32
            static let height: CGFloat = 32
        }
    }
}
