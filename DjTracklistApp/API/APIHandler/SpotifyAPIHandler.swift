//
//  SpotifyAPIHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
// Makes requests to the Spotify API
class SpotifyAPIHandler : APIHandler {
    
    // Performs a full API request including managing Access Tokens
    func request<T: Codable>(url: URL, method: String = "GET", body: Data? = nil) async throws -> T {
        // First we check whether we have some access token or none and get it
        guard let accessToken = SpotifyTokenHandler.shared.getCurrentAccessToken() else {
            // Request a new access token
            let newToken = try await SpotifyTokenHandler.shared.requestNewAccessToken()
            return try await makeRequest(url: url, method: method, body: body, accessToken: newToken.token)
        }
        
        return try await makeRequest(url: url, method: method, body: body, accessToken: accessToken.token)
    }
    
    // Makes a URL request and takes care of expired Access Token situation
    private func makeRequest<T: Codable>(url: URL, method: String, body: Data?, accessToken: String) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }

        switch httpResponse.statusCode {
        case 200...299:
            // Successful response
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        case 401:
            // Old token is not valid anymore, request a new access token and retry
            let newToken = try await SpotifyTokenHandler.shared.requestNewAccessToken()
            return try await makeRequest(url: url, method: method, body: body, accessToken: newToken.token)
        default:
            // Something went wrong
            throw APIError.requestFailed
        }
    }
    
    
}
