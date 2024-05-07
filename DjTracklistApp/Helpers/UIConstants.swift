//
//  UIConstants.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 24.01.2024.
//

import Foundation
import SwiftUI
@Observable
/// Constants used throughout the APP, usually for UI purposes
class UIConstants {
    static let shared = UIConstants()
    var screenSize: CGSize = .zero
    /// Constants for the bar Indicators
    struct Indicator {
        // 7 originally
        var spacing: CGFloat { UIConstants.shared.screenSize.height * 0.02 }
        var width: CGFloat { 1 }
        struct Big {
            var width: CGFloat { 1 }
            // 28 originally
            var height: CGFloat { UIConstants.shared.screenSize.height * 0.07 }
        }
        
        struct Small {
            var width: CGFloat { 1 }
            // 14 originally
            var height: CGFloat { UIConstants.shared.screenSize.height * 0.035 }
        }
        
        var big: Big {Big()}
        var small: Small {Small()}
    }
    
    /// Fonts used in the App
    struct Font {
        let regular = "Roboto-Regular"
        let light = "Roboto-Light"
        let bold = "Roboto-Bold"
        let medium = "Roboto-Medium"
    }
    
    struct Track {
        // 62 originally
        var height: CGFloat { UIConstants.shared.screenSize.height * 0.15 }
        let minimumBars: UInt = 16
        let nameSize: CGFloat = UIConstants.shared.screenSize.height * 0.035
        let artistsSize: CGFloat = UIConstants.shared.screenSize.height * 0.025
        let barsSize: CGFloat = UIConstants.shared.screenSize.height * 0.025
        let timeSize: CGFloat = UIConstants.shared.screenSize.height * 0.025
        let barSize: CGFloat = UIConstants.shared.screenSize.height * 0.025
        let addbarSize: CGFloat = UIConstants.shared.screenSize.height * 0.08
        let addButtonSize: CGFloat = UIConstants.shared.screenSize.height * 0.07
        struct Image {
            let width: CGFloat = UIConstants.shared.track.height * 0.55
            let height: CGFloat = UIConstants.shared.track.height * 0.55
        }
        var image: Image {Image()}
    }
    // Accessors for nested structs
    var indicator: Indicator { Indicator() }
    var font: Font { Font() }
    var track: Track { Track() }
}


