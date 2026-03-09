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
            "1" : Location(name: "b", longitude: 0.0, latitude: 0.0, createDate: Date(), userCreated: false),
            "2" : Location(name: "a", longitude: 0.0, latitude: 0.0, createDate: Date(), userCreated: false),
            "3" : Location(name: "1", longitude: 0.0, latitude: 0.0, createDate: Date(timeIntervalSince1970: 0), userCreated: true),
            "4" : Location(name: "2", longitude: 0.0, latitude: 0.0, createDate: Date(timeIntervalSince1970: 1), userCreated: true)
        ]
        let sut = PlacesPresenter.map(locations)
        #expect(sut.first?.id == "2")
        #expect(sut.first?.name == "a")
        #expect(sut[1].id == "1")
        #expect(sut[1].name == "b")
        #expect(sut[2].id == "3")
        #expect(sut[2].name == "1")
        #expect(sut.last?.id == "4")
        #expect(sut.last?.name == "2")
    }
    
    @Test("test returns ErrorViewData when mapping errors")
    func testMappingErrors() {
        for error in PlacesError.allCases {
            let sut = PlacesPresenter.map(error)

            #expect(sut.errorButton == .init(localized: "error.button"))
            #expect(sut.errorButtonHint == .init(localized: "error.button.hint"))

            let expectedLabel: String = switch error {
                case .noInternet: .init(localized: "error.label.nointernet")
                case .timeOut: .init(localized: "error.label.timeout")
                case .server, .invalidJSON: .init(localized: "error.label.server")
                case .invalidURL, .unknown: .init(localized: "error.label.unknown")
            }
            
            #expect(sut.errorLabel == expectedLabel)
        }
        
        let error = NSError(domain: "test", code: 0)
        let sut = PlacesPresenter.map(error)
        #expect(sut.errorLabel == .init(localized: "error.label.unknown"))
        #expect(sut.errorButton == .init(localized: "error.button"))
        #expect(sut.errorButtonHint == .init(localized: "error.button.hint"))
    }
    
    @Test("test returns AlertViewData for not installed error")
    func testNotInstalledErrorViewData() {
        let sut = PlacesPresenter.notInstalledErrorViewData()
        
        #expect(sut.title == .init(localized: "alert.title"))
        #expect(sut.message == .init(localized: "alert.message"))
        #expect(sut.dismissButton == .init(localized: "alert.button"))
    }
}
