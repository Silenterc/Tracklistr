//
//  Bar.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation

struct Bar {
    var bpm: Int
    
    var timeSig = 4
    var duration_ms: Int {
        (60000/bpm) * timeSig
    }
    var duration_s: Int {
        (60/bpm) * timeSig
    }
    
}
