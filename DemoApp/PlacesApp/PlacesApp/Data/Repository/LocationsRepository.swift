//
//  LocationsRepository.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

struct LocationsRepository {

    private let service: LocationsService

    init(service: LocationsService = .init()) {
        self.service = service
    }

    func fetchLocations() async throws -> [Location] {
        let response = try await service.fetchLocations()
        return LocationsMapper.map(response: response)
    }
}
