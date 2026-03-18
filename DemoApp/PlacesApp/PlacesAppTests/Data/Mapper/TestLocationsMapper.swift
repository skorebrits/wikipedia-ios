//
//  TestLocationsMapper.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing

@testable import PlacesApp

@MainActor
struct TestLocationsMapper {
    
    @Test("test returns locations when mapping")
    func testReturnsLocations() {
        let name = "test"
        let longitude: Double = 80.0
        let latitude: Double = 30.0
        let response = LocationsResponse(
            locations: [
                LocationApiModel(
                    name: name,
                    lat: latitude,
                    long: longitude
                )
            ]
        )
        let sut = LocationsMapper.map(response: response)
        
        #expect(sut.count == 1)
        #expect(sut.first?.name == name)
        #expect(sut.first?.longitude == longitude)
        #expect(sut.first?.latitude == latitude)
    }
}
