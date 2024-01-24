//
//  Bar.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation
import SwiftData
//struct Bar {
//    var bpm: Int
//    
//    var timeSig = 4
//    var duration_ms: Int {
//        (60000/bpm) * timeSig
//    }
//    var duration_s: Int {
//        (60/bpm) * timeSig
//    }
//    
//}
//final class Bar: Identifiable, Hashable, Codable, Equatable, Comparable, ExpressibleByIntegerLiteral {
//    @Attribute(.unique)let id: UUID
//    let value: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case id, value
//    }
//    init(_ value: Int, id: UUID = UUID()) {
//        self.value = max(0, value)
//        self.id = id
//    }
//    
//    init(_ value: Double, id: UUID = UUID()) {
//        self.value = max(0, Int(value))
//        self.id = id
//    }
//    
//    init(integerLiteral value: Int) {
//        id = UUID()
//        self.value = value
//    }
//    
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let id = try container.decode(UUID.self)
//        let value = try container.decode(Int.self)
//        self.id = id
//        self.value = value
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(value, forKey: .value)
//    }
//    
//    static func < (lhs: Bar, rhs: Bar) -> Bool {
//        return lhs.value < rhs.value
//    }
//
//    static func == (lhs: Bar, rhs: Bar) -> Bool {
//        return lhs.value == rhs.value
//    }
//    
//    
//    static func + (lhs: Bar, rhs: Bar) -> Bar {
//        return Bar(lhs.value + rhs.value)
//    }
//    
//    static func - (lhs: Bar, rhs: Bar) -> Bar {
//        return Bar(max(lhs.value - rhs.value, 0))
//    }
//    
//    static func * (lhs: Bar, rhs: Bar) -> Bar {
//        return Bar(lhs.value * rhs.value)
//    }
//    
//    static func / (lhs: Bar, rhs: Bar) -> Bar {
//        guard rhs.value != 0 else {
//            fatalError("Division by zero")
//        }
//        return Bar(lhs.value / rhs.value)
//    }
//    
//    func duration(bpm: Double, timeUnit: TimeUnit, timeSignature: Int = 4) -> Double {
//        switch(timeUnit) {
//        case .milliseconds: return Double(value) * (6000.0 / bpm) * Double(timeSignature)
//        case .seconds: return Double(value) * (60.0 / bpm) * Double(timeSignature)
//        case .minutes: return Double(value) * (1.0 / bpm) * Double(timeSignature)
//        }
//    }
//}
