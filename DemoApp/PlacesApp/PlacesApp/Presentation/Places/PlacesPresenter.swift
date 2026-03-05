//
//  PlacesPresenter.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

struct PlacesPresenter {

    static func map(_ locations: [String: Location]) -> [PlacesCellViewData] {
        locations.map {
            PlacesCellViewData(id: $0.key, name: $0.value.name)
        }
        .sorted(using: KeyPathComparator(\.name))
    }

    static func map(_ error: Error) -> ErrorViewData {
        .init(errorLabel: mapErrorLabel(error), errorButton: .init(localized: "error.button"))
    }

    private static func mapErrorLabel(_ error: Error) -> String {
        let placesError = (error as? PlacesError) ?? PlacesError(error: error)

        return switch placesError {
        case .noInternet:
            .init(localized: "error.label.nointernet")
        case .timeOut:
            .init(localized: "error.label.timeout")
        case .server, .invalidJSON:
            .init(localized: "error.label.server")
        case .invalidURL, .unknown:
            .init(localized: "error.label.unknown")
        }
    }
}
