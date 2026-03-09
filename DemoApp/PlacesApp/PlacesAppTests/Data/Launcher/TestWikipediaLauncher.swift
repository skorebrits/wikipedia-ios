//
//  TestWikipediaLauncher.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestWikipediaLauncher {
    
    @Test("test returns true when wikipedia installed")
    func testWikipediaInstalled() {
        let urlOpener = MockURLOpener(canOpenURL: true)
        let sut = WikipediaLauncher(urlOpener: urlOpener)
        
        #expect(sut.canLaunch)
    }
    
    @Test("test returns false when wikipedia not installed")
    func testWikipediaNotInstalled() {
        let urlOpener = MockURLOpener(canOpenURL: false)
        let sut = WikipediaLauncher(urlOpener: urlOpener)
        
        #expect(!sut.canLaunch)
    }
    
    @Test("test launches wikipedia when installed")
    func testLaunchWikipediaInstalled() {
        let urlOpener = MockURLOpener(canOpenURL: true)
        let sut = WikipediaLauncher(urlOpener: urlOpener)
        
        sut.launchWith(longitude: 0.0, latitude: 0.0)
        
        #expect(urlOpener.canOpenURLCalled)
        #expect(urlOpener.openCalled)
    }
    
    @Test("test does nothing when wikipedia not installed")
    func testLaunchWikipediaNotInstalled() {
        let urlOpener = MockURLOpener(canOpenURL: false)
        let sut = WikipediaLauncher(urlOpener: urlOpener)
        
        sut.launchWith(longitude: 0.0, latitude: 0.0)
        
        #expect(urlOpener.canOpenURLCalled)
        #expect(!urlOpener.openCalled)
    }
    
    @Test("test does nothing when invalid longitude and latitude")
    func testInvalidLongitudeAndLatitude() {
        let urlOpener = MockURLOpener(canOpenURL: false)
        let sut = WikipediaLauncher(urlOpener: urlOpener)
        
        sut.launchWith(longitude: 181.0, latitude: 91.0)
        
        #expect(!urlOpener.canOpenURLCalled)
        #expect(!urlOpener.openCalled)
    }
}
