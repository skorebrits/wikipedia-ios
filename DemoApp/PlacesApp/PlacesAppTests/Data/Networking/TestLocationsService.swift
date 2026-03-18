//
//  TestLocationsService.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

@MainActor
struct TestLocationsService {
    
    @Test("test return response when requesting locations")
    func testReturnResponse() async throws {
        let sut = StubIsURLSession.serviceWith(feedJSON: FeedFixtures.validJSONResponse)
        
        let locationsResponse = try await sut.fetchLocations()
        
        #expect(locationsResponse.locations.count == 4)
    }
    
    @Test("test throws error when requesting locations 404")
    func testThrowsError404() async throws {
        let sut = StubIsURLSession.serviceWith(feedJSON: FeedFixtures.validJSONResponse, statusCode: 404)
        
        await #expect(throws: PlacesError.server) {
            _ = try await sut.fetchLocations()
        }
    }
    
    @Test("test throws error when requesting locations invalidJSON")
    func testThrowsErrorInvalidJSON() async throws {
        let sut = StubIsURLSession.serviceWith(feedJSON: FeedFixtures.invalidJSONResponse)
        
        await #expect(throws: PlacesError.invalidJSON) {
            _ = try await sut.fetchLocations()
        }
    }
    
    @Test("test throws error when requesting locations offline")
    func testThrowsErrorOffline() async throws {
        let sut = StubIsURLSession.serviceWith(feedJSON: nil, statusCode: 200, error: URLError(.notConnectedToInternet))
        
        await #expect(throws: PlacesError.noInternet) {
            _ = try await sut.fetchLocations()
        }
    }
}
