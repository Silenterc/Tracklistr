//
//  AccessTokenHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
// Handler for acquiring and managing Access Tokens for some API
protocol AccessTokenHandler {
    
    func requestNewAccessToken() async throws -> AccessToken
    func getCurrentAccessToken() -> AccessToken?
    
    
}
