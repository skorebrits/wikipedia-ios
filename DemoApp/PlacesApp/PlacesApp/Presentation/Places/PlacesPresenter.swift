//
//  PlacesPresenter.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

struct PlacesPresenter {

    static func map(_ error: Error) -> ErrorViewData {
        .init(errorLabel: mapErrorLabel(error), errorButton: .init(localized: "error.button"))
    }

    private static func mapErrorLabel(_ error: Error) -> String {
        let placesError = (error as? PlacesError) ?? PlacesError(error: error)

        return switch placesError {
        case .noInternet:
            .init(localized: "error.title.nointernet")
        case .timeOut:
            .init(localized: "error.title.timeout")
        case .server, .invalidJSON:
            .init(localized: "error.title.server")
        case .invalidURL, .unknown:
            .init(localized: "error.title.unknown")
        }
    }
}
