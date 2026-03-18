//
//  CreateLocationPresenter.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 08/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

@MainActor
struct TestCreateLocationPresenter {
    
    @Test("test returns CreateLocationViewData")
    func testCreateLocationViewData() {
        let sut = CreateLocationPresenter.map(hasValidInput: true)
        
        #expect(sut.title == .init(localized: "create.location.title"))
        #expect(sut.labelName == .init(localized: "create.location.label.name"))
        #expect(sut.labelLongitude == .init(localized: "create.location.label.longitude"))
        #expect(sut.labelLatitude == .init(localized: "create.location.label.latitude"))
        #expect(sut.buttonOk == .init(localized: "create.location.button.ok"))
        #expect(sut.buttonOkHint == .init(localized: "create.location.button.ok.hint"))
        #expect(sut.buttonCancel == .init(localized: "create.location.button.cancel"))
        #expect(sut.buttonCancelHint == .init(localized: "create.location.button.cancel.hint"))
        #expect(sut.buttonOkEnabled)
    }
}
