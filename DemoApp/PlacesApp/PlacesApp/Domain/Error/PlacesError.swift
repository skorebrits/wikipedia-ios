//
//  PlacesError.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

enum PlacesError: Error {
    case invalidURL
    case invalidJSON
    case noInternet
    case timeOut
    case server
    case unknown

    init(error: Error) {
        if let placesError = error as? PlacesError {
            self = placesError
            return
        }

        guard let error = error as? URLError else {
            self = .unknown
            return
        }

        switch error.code {
        case .notConnectedToInternet:
            self = .noInternet

        case .timedOut:
            self = .timeOut

        default:
            self = .server
        }
    }
}
