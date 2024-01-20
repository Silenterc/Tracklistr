//
//  SpotifyTokenHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
// Handler of the Spotify API Access Token according to the client credentials Authorization Flow
class SpotifyTokenHandler : AccessTokenHandler {
    // We only need a singleton instance of this Handler
    static let shared = SpotifyTokenHandler()
    //Currently assigned Access Token
    private var accessToken: AccessToken?
    
    
    
    // Requests and returns a new Access Token according to the client credentials Authorization Flow
    func requestNewAccessToken() async throws -> AccessToken {
        var urlRequest = URLRequest(url: APIConstants.Spotify.tokenURL)
        urlRequest.allHTTPHeaderFields = [
            "Authorization" : SpotifyAuthorization.shared.encodedKeyArgument,
            "Content-Type" : APIConstants.Spotify.contentType]
        
        var httpBody = URLComponents()
        httpBody.queryItems = [URLQueryItem(name: "grant_type", value: "client_credentials")]
        urlRequest.httpBody = httpBody.query?.data(using: .utf8)
        urlRequest.httpMethod = "POST"
       
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            // Successful call
            do {
                // Save and return the new token
                let decoder = JSONDecoder()
                let newAccessToken = try decoder.decode(AccessToken.self, from: data)
                self.accessToken = newAccessToken
                return newAccessToken
            } catch {
                throw APIError.decodingFailed
            }
        } else {
            // Unsuccessful call
            throw APIError.requestFailed
        }
    }
    
    func getCurrentAccessToken() -> AccessToken? {
        self.accessToken
    }
    
    
}
