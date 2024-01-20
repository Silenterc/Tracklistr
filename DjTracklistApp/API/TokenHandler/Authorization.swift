//
//  Authorization.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation

class SpotifyAuthorization {
    static let shared = SpotifyAuthorization()
    private let clientID = Bundle.main.infoDictionary?["CLIENT_ID"] as? String
    private let clientSecret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as! String
    
    var encodedKeyArgument: String {
        let nonEncodedKey = "\(clientID ?? ""):\(clientSecret )"
        let encodedKey = nonEncodedKey.data(using: .utf8)?.base64EncodedString() ?? ""
        return "Basic \(encodedKey)"
    }
    
}
