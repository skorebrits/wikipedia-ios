//
//  PlacesPresenter.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

struct PlacesPresenter {

    static func map(_ locations: [String: Location]) -> [PlacesCellViewData] {
        let fetched = locations
            .filter { !$0.value.userCreated }
            .sorted { $0.value.name < $1.value.name }

        let userCreated = locations
            .filter { $0.value.userCreated }
            .sorted { $0.value.createDate < $1.value.createDate }

        return (fetched + userCreated).map {
            .init(id: $0.key, name: $0.value.name)
        }
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
