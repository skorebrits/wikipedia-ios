//
//  TestPlacesViewModel.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 09/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestPlacesViewModel {
    
    @Test("test has loading state when init")
    func testLoadingStateOnInit() {
        let sut = PlacesViewModel()
        
        guard case .loading = sut.state else {
            Issue.record("Expected loading state")
            return
        }
        
        #expect(!sut.createLocationEnabled)
    }
    
    @Test("test has error state when service error on location fetching")
    func testErrorStateOnServiceError() async {
        let service = StubIsURLSession.serviceWith(feedJSON: nil, statusCode: 200, error: URLError(.notConnectedToInternet))
        let repository = await LocationsRepository(service: service)
        let sut = await PlacesViewModel(repository: repository)
        await sut.fetchLocations()
        
        guard case .error(_) = await sut.state else {
            Issue.record("Expected error state")
            return
        }
        
        #expect(!sut.createLocationEnabled)
    }
    
    @Test("test has loaded state when locations are fetched")
    func testLoadedStateOnLocationsFetched() async {
        let service = StubIsURLSession.serviceWith(feedJSON: FeedFixtures.validJSONResponse)
        let repository = await LocationsRepository(service: service)
        let sut = await PlacesViewModel(repository: repository)
        await sut.fetchLocations()
        
        guard case .loaded(_) = await sut.state else {
            Issue.record("Expected loaded state")
            return
        }
        
        #expect(sut.createLocationEnabled)
    }
    
    @Test("test location added to list when adding location")
    func testLocationAdded() {
        let sut = PlacesViewModel()
        sut.addLocation(location:
                .init(
                    name: "test",
                    longitude: 0.0,
                    latitude: 0.0,
                    createDate: Date(),
                    userCreated: true
                )
        )
        
        guard case .loaded(let viewData) = sut.state else {
            Issue.record("Expected loaded state")
            return
        }
        
        #expect(viewData.count == 1)
        #expect(viewData.first?.name == "test")
    }
    
    @Test("test open wikipedia app when selected")
    func testOpenWikipediaWhenSelected() {
        let urlOpener = MockURLOpener(canOpenURL: true)
        let launcher = Launcher(urlOpener: urlOpener)
        let sut = PlacesViewModel(repository: .init(), launcher: launcher)
        sut.addLocation(location:
                .init(
                    name: "test",
                    longitude: 0.0,
                    latitude: 0.0,
                    createDate: Date(),
                    userCreated: true
                )
        )
        
        guard
            case .loaded(let viewData) = sut.state,
            let cell = viewData.first
        else {
            Issue.record("Expected loaded state")
            return
        }
        
        sut.select(id: cell.id)
        #expect(urlOpener.canOpenURLCalled)
        #expect(urlOpener.openCalled)
        #expect(!sut.showAlert)
    }
    
    @Test("test does nothing when seleced invalid id")
    func testSelectedOnInvalidId() {
        let urlOpener = MockURLOpener(canOpenURL: true)
        let launcher = Launcher(urlOpener: urlOpener)
        let sut = PlacesViewModel(repository: .init(), launcher: launcher)
        sut.addLocation(location:
                .init(
                    name: "test",
                    longitude: 0.0,
                    latitude: 0.0,
                    createDate: Date(),
                    userCreated: true
                )
        )
        
        guard
            case .loaded(_) = sut.state
        else {
            Issue.record("Expected loaded state")
            return
        }
        
        sut.select(id: "invalid id")
        #expect(!urlOpener.canOpenURLCalled)
        #expect(!urlOpener.openCalled)
        #expect(!sut.showAlert)
    }
    
    @Test("test shows alert when wikipedia not installed")
    func testShowAlert() {
        let urlOpener = MockURLOpener(canOpenURL: false)
        let launcher = Launcher(urlOpener: urlOpener)
        let sut = PlacesViewModel(repository: .init(), launcher: launcher)
        sut.addLocation(location:
                .init(
                    name: "test",
                    longitude: 0.0,
                    latitude: 0.0,
                    createDate: Date(),
                    userCreated: true
                )
        )
        
        guard
            case .loaded(let viewData) = sut.state,
            let cell = viewData.first
        else {
            Issue.record("Expected loaded state")
            return
        }
        
        sut.select(id: cell.id)
        #expect(urlOpener.canOpenURLCalled)
        #expect(!urlOpener.openCalled)
        #expect(sut.showAlert)
    }
}
