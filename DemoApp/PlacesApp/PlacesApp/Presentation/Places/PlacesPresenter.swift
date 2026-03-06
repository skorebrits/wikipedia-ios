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

    static func notInstalledErrorViewData() -> AlertViewData {
        .init(
            title: .init(localized: "alert.title"),
            message: .init(localized: "alert.message"),
            dismissButton: .init(localized: "alert.button")
        )
    }
    
    static func createLocationViewData() -> CreateLocationViewData {
        .init(
            title: .init(localized: "create.location.title"),
            labelName: .init(localized: "create.location.label.name"),
            labelLongitude: .init(localized: "create.location.label.longitude"),
            labelLatitude: .init(localized: "create.location.label.latitude"),
            buttonOk: .init(localized: "create.location.button.ok"),
            buttonCancel: .init(localized: "create.location.button.cancel")
        )
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
