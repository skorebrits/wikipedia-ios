//
//  TestCreateLocationViewModel.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 09/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestCreateLocationViewModel {
    
    @Test("test returns okButton disabled when initialized")
    func testInitialStateIsInvalid() {
        let sut = CreateLocationViewModel()
        #expect(sut.viewData.buttonOkEnabled == false)
    }

    @Test("test returns okButton enabled and location with correct values when fields are set")
    func testLocationReturnsCorrectValues() {
        let sut = CreateLocationViewModel()
        sut.nameField = "Amsterdam"
        sut.longitudeField = "4.8339215"
        sut.latitudeField = "52.3547498"

        let location = sut.location
        sut.validateLocation()
        #expect(location.name == "Amsterdam")
        #expect(location.longitude == 4.8339215)
        #expect(location.latitude == 52.3547498)
        #expect(location.userCreated == true)
        
        #expect(sut.viewData.buttonOkEnabled == true)
    }

    @Test("test returns invalid state when name is empty")
    func testEmptyNameDisablesButton() {
        let sut = CreateLocationViewModel()
        sut.nameField = ""
        sut.longitudeField = "4.8339215"
        sut.latitudeField = "52.3547498"
        sut.validateLocation()
        #expect(sut.viewData.buttonOkEnabled == false)
    }

    @Test("test returns invalid state when longitude exceeds 180")
    func testInvalidLongitudeDisablesButton() {
        let sut = CreateLocationViewModel()
        sut.nameField = "Amsterdam"
        sut.longitudeField = "181.0"
        sut.latitudeField = "52.3547498"
        sut.validateLocation()
        #expect(sut.viewData.buttonOkEnabled == false)
    }

    @Test("test returns invalid state when latitude exceeds 90")
    func testInvalidLatitudeDisablesButton() {
        let sut = CreateLocationViewModel()
        sut.nameField = "Amsterdam"
        sut.longitudeField = "4.8339215"
        sut.latitudeField = "91.0"
        sut.validateLocation()
        #expect(sut.viewData.buttonOkEnabled == false)
    }

    @Test("test returns valid state when longitude is at boundary values -180 and 180")
    func testBoundaryLongitudeValuesAreValid() {
        let sut = CreateLocationViewModel()
        sut.nameField = "Amsterdam"
        sut.latitudeField = "52.3547498"

        sut.longitudeField = "-180.0"
        sut.validateLocation()
        #expect(sut.viewData.buttonOkEnabled == true)

        sut.longitudeField = "180.0"
        sut.validateLocation()
        #expect(sut.viewData.buttonOkEnabled == true)
    }

    @Test("test returns valid state when latitude is at boundary values -90 and 90")
    func testBoundaryLatitudeValuesAreValid() {
        let sut = CreateLocationViewModel()
        sut.nameField = "Amsterdam"
        sut.longitudeField = "4.8339215"

        sut.latitudeField = "-90.0"
        sut.validateLocation()
        #expect(sut.viewData.buttonOkEnabled == true)

        sut.latitudeField = "90.0"
        sut.validateLocation()
        #expect(sut.viewData.buttonOkEnabled == true)
    }
    
    @Test("test returns location with default longitude and latitude on invalid text")
    func testDefaultLongitudeAndLatitude() {
        let sut = CreateLocationViewModel()
        sut.longitudeField = "invalid"
        sut.latitudeField = "invalid"
        
        #expect(sut.location.longitude == 0.0)
        #expect(sut.location.latitude == 0.0)
    }
}
