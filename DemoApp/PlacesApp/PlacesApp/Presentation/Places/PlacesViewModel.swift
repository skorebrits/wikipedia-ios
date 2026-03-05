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

    private let repository: LocationsRepository

    init(repository: LocationsRepository = .init()) {
        self.repository = repository
        state = .loading
    }

    func fetchLocations() async {
        do {
            state = .loading
            let fetchedLocations  = try await repository.fetchLocations()
            locations = .init(uniqueKeysWithValues: fetchedLocations.map { (UUID().uuidString, $0)})
            state = .loaded(PlacesPresenter.map(locations))
        } catch {
            state = .error(PlacesPresenter.map(error))
        }
    }

    func select(id: String) {
        debugPrint("did select: \(String(describing: locations[id]?.name))")
    }
}
