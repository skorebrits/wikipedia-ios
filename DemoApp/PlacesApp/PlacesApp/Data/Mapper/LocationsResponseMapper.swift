//
//  LocationsResponseMapper.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

struct LocationsResponseMapper {

    private let jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
    }

    func convert(json: Data) throws -> LocationsResponse {
        do {
            return try jsonDecoder.decode(LocationsResponse.self, from: json)
        } catch {
            throw PlacesError.invalidJSON
        }
    }
}
