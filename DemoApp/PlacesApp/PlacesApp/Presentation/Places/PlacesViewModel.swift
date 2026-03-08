//
//  PlacesViewModel.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import SwiftUI

@Observable
final class PlacesViewModel {

    var state: PlacesState
    var locations: [String: Location] = [:]
    var alertViewData = PlacesPresenter.notInstalledErrorViewData()
    var showAlert = false
    var showCreateLocation = false

    private let repository: LocationsRepository
    private let launcher: WikipediaLauncher

    init(repository: LocationsRepository = .init(), launcher: WikipediaLauncher = .init()) {
        self.repository = repository
        self.launcher = launcher
        state = .loading
    }

    func fetchLocations() async {
        do {
            state = .loading
            let fetchedLocations  = try await repository.fetchLocations()
            locations = .init(
                uniqueKeysWithValues:
                    fetchedLocations
                    .map { (UUID().uuidString, $0)}
            )
            state = .loaded(PlacesPresenter.map(locations))
        } catch {
            state = .error(PlacesPresenter.map(error))
        }
    }

    func select(id: String) {
        guard let location = locations[id] else { return }

        guard launcher.canLaunch else {
            showAlert = true
            return
        }

        launcher.launchWith(longitude: location.longitude, latitude: location.latitude)
    }

    func addLocation(location: Location) {
        locations[UUID().uuidString] = location
        state = .loaded(PlacesPresenter.map(locations))
    }
}
