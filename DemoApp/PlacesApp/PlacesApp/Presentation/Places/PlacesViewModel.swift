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
    var createLocationEnabled: Bool {
        state.isLoaded
    }

    private let repository: LocationsRepository
    private let launcher: Launcher

    init(repository: LocationsRepository = .init(), launcher: Launcher = .init()) {
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

        guard
            let url = try? URL.wikipediaOpenURLWith(longitude: location.longitude, latitude: location.latitude),
            launcher.canLaunchURL(url: url)
        else {
            showAlert = true
            return
        }

        Task { @MainActor in
            await launcher.launchWith(url: url)
        }
    }

    func addLocation(location: Location) {
        locations[UUID().uuidString] = location
        state = .loaded(PlacesPresenter.map(locations))
    }
}
