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
}
