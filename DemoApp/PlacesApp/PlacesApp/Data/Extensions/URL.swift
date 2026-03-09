//
//  URL+.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

extension URL {

    static func locations(url: String = PlacesConstants.locationsURL) throws -> URL {
        guard let url = URL(string: url) else {
            throw PlacesError.invalidURL
        }

        return url
    }

    static func wikipediaOpenURLWith(longitude: Double, latitude: Double) -> URL? {
        guard longitude >= -180, longitude <= 180, latitude >= -90, latitude <= 90 else {
            return nil
        }

        var components = URLComponents()
        components.scheme = PlacesConstants.wikipediaScheme
        components.host = PlacesConstants.wikipediaHost
        components.queryItems = [
            .init(name: "lon", value: "\(longitude)"),
            .init(name: "lat", value: "\(latitude)")
        ]

        return components.url
    }
}
