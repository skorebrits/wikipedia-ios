//
//  TestLocationsResponseMapper.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestLocationsResponseMapper {
    
    @Test("test returns response when json is valid")
    func testValidJSON() throws {
        let sut = LocationsResponseMapper()
        let data = try #require(FeedFixtures.validJSONResponse.data(using: .utf8))
        let response = try sut.convert(json: data)
        
        #expect(response.locations.count == 4)
    }
    
    @Test("test throws error when json is invalid")
    func testInValidJSON() throws {
        let sut = LocationsResponseMapper()
        let data = try #require(FeedFixtures.invalidJSONResponse.data(using: .utf8))
        
        #expect(throws: PlacesError.invalidJSON) {
            _ = try sut.convert(json: data)
        }
    }
}
