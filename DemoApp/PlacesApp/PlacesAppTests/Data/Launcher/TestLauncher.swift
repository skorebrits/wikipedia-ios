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
    func testCanLaunchURL() throws {
        let urlOpener = MockURLOpener(canOpenURL: true)
        let url = try URL.wikipediaOpenURLWith(longitude: 0, latitude: 0)
        let sut = Launcher(urlOpener: urlOpener)
        
        #expect(sut.canLaunchURL(url: url))
    }
    
    @Test("test returns false when cannot launch")
    func testCannotLaunchURL() throws {
        let urlOpener = MockURLOpener(canOpenURL: false)
        let url = try URL.wikipediaOpenURLWith(longitude: 0, latitude: 0)
        let sut = Launcher(urlOpener: urlOpener)
        
        #expect(!sut.canLaunchURL(url: url))
    }
    
    @Test("test launches url")
    func testLaunchURL() throws {
        let urlOpener = MockURLOpener(canOpenURL: true)
        let url = try URL.wikipediaOpenURLWith(longitude: 0, latitude: 0)
        let sut = Launcher(urlOpener: urlOpener)
        
        sut.launchWith(url: url)
        
        #expect(urlOpener.canOpenURLCalled)
        #expect(urlOpener.openCalled)
    }
    
    @Test("test does nothing if cannot launch")
    func testLaunchURLNotSupported() throws {
        let urlOpener = MockURLOpener(canOpenURL: false)
        let url = try URL.wikipediaOpenURLWith(longitude: 0, latitude: 0)
        let sut = Launcher(urlOpener: urlOpener)
        
        sut.launchWith(url: url)
        
        #expect(urlOpener.canOpenURLCalled)
        #expect(!urlOpener.openCalled)
    }
}
