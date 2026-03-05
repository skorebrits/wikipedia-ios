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
}
