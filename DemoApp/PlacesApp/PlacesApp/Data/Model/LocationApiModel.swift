//
//  LocationApiModel.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

struct LocationApiModel: Decodable {
    let name: String?
    let lat: Double
    let long: Double
}
