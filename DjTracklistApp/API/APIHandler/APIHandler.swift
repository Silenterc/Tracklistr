//
//  APIHandler.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 20.01.2024.
//

import Foundation
// Responsible for making requests to an API
protocol APIHandler {
    
    func request<T: Codable>(url: URL, method: String, body: Data?) async throws -> T
    
}
