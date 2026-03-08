//
//  CreateLocationViewModel.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 08/03/2026.
//

import SwiftUI
import Foundation

@Observable
final class CreateLocationViewModel {

    var nameField: String = ""
    var longitudeField: String = "0.0"
    var latitudeField: String = "0.0"

    var viewData = CreateLocationPresenter.map(hasValidInput: false)
    var location: Location {
        .init(
            name: nameField,
            longitude: Double(longitudeField) ?? 0.0,
            latitude: Double(latitudeField) ?? 0.0,
            createDate: Date(),
            userCreated: true
        )
    }

    func validateLocation() {
        guard !nameField.isEmpty else {
            viewData = CreateLocationPresenter.map(hasValidInput: false)
            return
        }

        guard
            let longitude = Double(longitudeField),
            longitude >= -180.0 && longitude <= 180.0
        else {
            viewData = CreateLocationPresenter.map(hasValidInput: false)
            return
        }

        guard
            let latitude = Double(latitudeField),
            latitude >= -90.0 && latitude <= 90.0
        else {
            viewData = CreateLocationPresenter.map(hasValidInput: false)
            return
        }

        viewData = CreateLocationPresenter.map(hasValidInput: true)
    }
}
