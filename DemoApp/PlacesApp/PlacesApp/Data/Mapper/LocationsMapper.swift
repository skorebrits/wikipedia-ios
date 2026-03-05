//
//  LocationsMapper.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

struct LocationsMapper {
    
    static func map(response: LocationsResponse) -> [Location] {
        response.locations.map {
            Location(
                name: $0.name ?? "-",
                longitude: $0.long,
                latitude: $0.lat
            )
        }
    }
}
