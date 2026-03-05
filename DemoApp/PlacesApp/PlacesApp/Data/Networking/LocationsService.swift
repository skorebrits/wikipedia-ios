//
//  LocationsService.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

struct LocationsService {

    private let urlSession: IsURLSession
    private let mapper: LocationsResponseMapper

    init(
        urlSession: IsURLSession = URLSession.shared,
        mapper: LocationsResponseMapper = .init()
    ) {
        self.urlSession = urlSession
        self.mapper = mapper
    }

    func fetchLocations() async throws -> LocationsResponse {
        do {
            let url: URL = try .locations()
            let (data, response) = try await urlSession.data(for: .init(url: url), delegate: nil)

            guard response.isValidHTTPResponse else {
                throw PlacesError.server
            }

            return try mapper.convert(json: data)
        } catch {
            throw PlacesError(error: error)
        }
    }
}
