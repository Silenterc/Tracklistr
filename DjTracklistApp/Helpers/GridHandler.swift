//
//  GridHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 13.02.2024.
//

import Foundation
/// Class responsible for operations regarding calculating widths, positions, sizes of the track cells on the track timeline,
/// so they are able to snap to the timeline view -> almost like a grid
class GridHandler {
    
    let fourBarsWidth: CGFloat = UIConstants.Indicator.width + UIConstants.Indicator.spacing
    
    static let shared = GridHandler()
    
    func getWidthFromBars(bars: UInt) -> CGFloat {
        let fourBars = bars / 4
        return CGFloat(fourBars) * fourBarsWidth
        
    }
    
    func roundWidth(width: CGFloat) -> CGFloat {
        let remainder = width.truncatingRemainder(dividingBy: fourBarsWidth)
        if (remainder < fourBarsWidth / 2) {
            return width - remainder
            
        } else {
            return width - remainder + fourBarsWidth
            
        }
    }
    
}
