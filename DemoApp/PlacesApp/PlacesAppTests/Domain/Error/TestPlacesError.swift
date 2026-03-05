//
//  TestPlacesError.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestPlacesError {
    
    @Test("test returns nointernet")
    func testNoInternet() {
        let error = URLError(.notConnectedToInternet)
        let sut = PlacesError(error: error)
        
        #expect(sut == PlacesError.noInternet)
    }
    
    @Test("test returns timeout")
    func testTimout() {
        let error = URLError(.timedOut)
        let sut = PlacesError(error: error)
        
        #expect(sut == PlacesError.timeOut)
    }
    
    @Test("test returns server")
    func testServer() {
        let error = URLError(.badURL)
        let sut = PlacesError(error: error)
        
        #expect(sut == PlacesError.server)
    }
    
    @Test("test returns unknown")
    func testUnknown() {
        let error = NSError(domain: "test", code: 0)
        let sut = PlacesError(error: error)
        
        #expect(sut == PlacesError.unknown)
    }
}
