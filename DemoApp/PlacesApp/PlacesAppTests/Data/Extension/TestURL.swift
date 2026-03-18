//
//  TestURL+Locations.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

@MainActor
struct TestURLLocations {
    
    @Test("test returns url when url is valid")
    func testValidURL() throws {
        let url: URL = try .locations()
        let expected = PlacesConstants.locationsURL
        #expect(url.absoluteString == expected)
    }
    
    @Test("test throws error when url is invalid")
    func testInalidURL() {
        #expect(throws: PlacesError.invalidURL) {
            _ = try URL.locations(url: "")
        }
    }
    
    @Test("test returns wikipedia url")
    func testWikipediaURL() throws {
        let sut = try URL.wikipediaOpenURLWith(longitude: 1.0, latitude: 1.0)
        
        #expect(sut.absoluteString == "wikipedia://places?lon=1.0&lat=1.0")
    }
    
    @Test("test returns nil on invalid longitude")
    func testWikipediaURLOnInvalidLongitude() {
        #expect(throws: PlacesError.invalidURL) {
            _ = try URL.wikipediaOpenURLWith(longitude: 181.0, latitude: 91.0)
        }
    }
}
