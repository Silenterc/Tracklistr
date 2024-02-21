//
//  Authorization.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation

class SpotifyAuthorization {
    static let shared = SpotifyAuthorization()
    private let clientID = Bundle.main.infoDictionary?["CLIENT_ID_SPOT"] as? String
    private let clientSecret = Bundle.main.infoDictionary?["CLIENT_SECRET_SPOT"] as? String
    
    var encodedKeyArgument: String {
        let nonEncodedKey = "\(clientID ?? ""):\(clientSecret ?? "")"
        let encodedKey = nonEncodedKey.data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(encodedKey)"
    }
}

class MusicApiAuthorization {
    static let shared = MusicApiAuthorization()
    private let clientID = Bundle.main.infoDictionary?["CLIENT_ID_MUSI"] as? String
    var token: String {
        "Token \(clientID ?? "")"
    }
}
