//
//  CreateLocationPresenter.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 08/03/2026.
//

import Foundation

struct CreateLocationPresenter {

    static func map(hasValidInput: Bool) -> CreateLocationViewData {
        .init(
            title: .init(localized: "create.location.title"),
            labelName: .init(localized: "create.location.label.name"),
            labelLongitude: .init(localized: "create.location.label.longitude"),
            labelLatitude: .init(localized: "create.location.label.latitude"),
            buttonOk: .init(localized: "create.location.button.ok"),
            buttonCancel: .init(localized: "create.location.button.cancel"),
            buttonOkEnabled: hasValidInput
        )
    }
}
