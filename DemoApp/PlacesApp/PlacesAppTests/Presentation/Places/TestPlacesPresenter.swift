//
//  TestPlacesPresenter.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestPlacesPresenter {
    
    @Test("test returns PlacesViewCellData when mapping locations")
    func testMappingLocations() {
        let locations = [
            "1" : Location(name: "b", longitude: 0.0, latitude: 0.0),
            "2" : Location(name: "a", longitude: 0.0, latitude: 0.0)
        ]
        let sut = PlacesPresenter.map(locations)
        #expect(sut.first?.id == "2")
        #expect(sut.first?.name == "a")
        #expect(sut.last?.id == "1")
        #expect(sut.last?.name == "b")
    }
    
    @Test("test returns ErrorViewData when mapping errors")
    func testMappingErrors() {
        for error in PlacesError.allCases {
            let sut = PlacesPresenter.map(error)
            
            #expect(sut.errorButton == .init(localized: "error.button"))
            
            let expectedLabel: String = switch error {
                case .noInternet: .init(localized: "error.label.nointernet")
                case .timeOut: .init(localized: "error.label.timeout")
                case .server, .invalidJSON: .init(localized: "error.label.server")
                case .invalidURL, .unknown: .init(localized: "error.label.unknown")
            }
            
            #expect(sut.errorLabel == expectedLabel)
        }
    }
    
    @Test("test returns AlertViewData for not installed error")
    func testNotInstalledErrorViewData() {
        let sut = PlacesPresenter.notInstalledErrorViewData()
        
        #expect(sut.title == .init(localized: "alert.title"))
        #expect(sut.message == .init(localized: "alert.message"))
        #expect(sut.dismissButton == .init(localized: "alert.button"))
    }
    
    @Test("test returns CreateLocationViewData")
    func testCreateLocationViewData() {
        let sut = PlacesPresenter.createLocationViewData()
        
        #expect(sut.title == .init(localized: "create.location.title"))
        #expect(sut.labelName == .init(localized: "create.location.label.name"))
        #expect(sut.labelLongitude == .init(localized: "create.location.label.longitude"))
        #expect(sut.labelLatitude == .init(localized: "create.location.label.latitude"))
        #expect(sut.buttonOk == .init(localized: "create.location.button.ok"))
        #expect(sut.buttonCancel == .init(localized: "create.location.button.cancel"))
    }
}
