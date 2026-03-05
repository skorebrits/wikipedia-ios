//
//  TestLocationsService.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestLocationsService {
    
    @Test("test return response when requesting locations")
    func testReturnResponse() async throws {
        let sut = try createSut(feedJSON: FeedFixtures.validJSONResponse)
        
        let locationsResponse = try await sut.fetchLocations()
        
        #expect(locationsResponse.locations.count == 4)
    }
    
    @Test("test throws error when requesting locations 404")
    func testThrowsError404() async throws {
        let sut = try createSut(feedJSON: FeedFixtures.validJSONResponse, statusCode: 404)
        
        await #expect(throws: PlacesError.server) {
            _ = try await sut.fetchLocations()
        }
    }
    
    @Test("test throws error when requesting locations invalidJSON")
    func testThrowsErrorInvalidJSON() async throws {
        let sut = try createSut(feedJSON: FeedFixtures.invalidJSONResponse)
        
        await #expect(throws: PlacesError.invalidJSON) {
            _ = try await sut.fetchLocations()
        }
    }
    
    @Test("test throws error when requesting locations offline")
    func testThrowsErrorOffline() async throws {
        let sut = try createSut(feedJSON: nil, statusCode: 200, error: URLError(.notConnectedToInternet))
        
        await #expect(throws: PlacesError.noInternet) {
            _ = try await sut.fetchLocations()
        }
    }
    
    private func createSut(
        feedJSON: String?,
        statusCode: Int = 200,
        error: Error? = nil
    ) throws -> LocationsService {
        let data = feedJSON?.data(using: .utf8)
        let url = try #require(URL(string:PlacesConstants.locationsURL))
        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )
        let sessionResponse: (Data, URLResponse)? = if let data, let response {
            (data, response)
        } else {
            nil
        }
        let urlSession = StubIsURLSession(response: sessionResponse, error: error)
        
        return LocationsService(urlSession: urlSession)
    }
}
