//
//  SpotifyServiceTests.swift
//  DjTracklistAppTests
//
//  Created by Lukas Zima on 20.01.2024.
//

import XCTest

final class SpotifyServiceTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        let service = SpotifyService(apiHandler: .init())
        var result:[Track]
        result = try await service.searchTracks(query: "Solar Sys")
        let solarSystem = try await service.getTrackWithFeatures(id: result[0].id)
        print(solarSystem.audioFeatures!.bpm)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
