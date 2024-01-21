//
//  URLSessionProtocol.swift
//  DjTracklistApp
//
//  Created by Lukas Zima on 21.01.2024.
//

import Foundation

// Protocol for URLSession operations, will make testing the API handlers easier
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// The real URLSession
extension URLSession: URLSessionProtocol {}

// Mock implementation for testing
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    // TODO
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }

        if let data = data, let response = response {
            return (data, response)
        }

        throw NSError(domain: "MockURLSession", code: 0, userInfo: nil)
    }
}
