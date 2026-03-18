//
//  TestLocationsRepository.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing

@testable import PlacesApp

@MainActor
struct TestLocationsRepository {
    
    @Test("test returns locations when fetching locations")
    func testReturnsLocations() async throws {
        let service = StubIsURLSession.serviceWith(feedJSON: FeedFixtures.validJSONResponse)
        let sut = LocationsRepository(service: service)
        
        let locations = try await sut.fetchLocations()
        
        #expect(locations.count == 4)
    }
    
    @Test("test throws error when fetching invalid feed")
    func testThrowsError() async throws {
        let service = StubIsURLSession.serviceWith(feedJSON: FeedFixtures.invalidJSONResponse)
        let sut = LocationsRepository(service: service)
        
        await #expect(throws: PlacesError.invalidJSON) {
            _ = try await sut.fetchLocations()
        }
    }
}
