//
//  MusicAPIHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.02.2024.
//

import Foundation

class MusicAPIHandler: APIHandler {
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    func request<T>(url: URL, method: String = "POST", body: Data?) async throws -> T where T : Decodable, T : Encodable {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(MusicApiAuthorization.shared.token, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await urlSession.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            // Successful response
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        default:
            // Something went wrong, probably too many requests
            throw APIError.requestFailed
        }
        
        
        
        
    }
    
    
    
    
}
