//
//  MockURLOpener.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import UIKit

@testable import PlacesApp

final class MockURLOpener: URLOpener {
    
    var canOpenURLCalled: Bool = false
    var openCalled: Bool = false
    
    private let canOpenURL: Bool
    
    init(canOpenURL: Bool) {
        self.canOpenURL = canOpenURL
    }
    
    func canOpenURL(_ url: URL) -> Bool {
        canOpenURLCalled = true
        return canOpenURL
    }
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any]) async -> Bool {
        openCalled = true
        return canOpenURLCalled
    }
}
