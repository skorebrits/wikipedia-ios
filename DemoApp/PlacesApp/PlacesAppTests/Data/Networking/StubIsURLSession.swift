//
//  StubIsURLSession.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

@testable import PlacesApp

struct StubIsURLSession: IsURLSession {
    
    private let response: (Data, URLResponse)?
    private let error: Error?
    
    init(response: (Data, URLResponse)? = nil, error: Error? = nil) {
        self.response = response
        self.error = error
    }
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        guard let response = response else {
            if let error = error {
                throw error
            } else {
                fatalError("No response or error provided")
            }
        }
        return response
    }
}
