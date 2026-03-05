//
//  StubIsURLSession.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
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
    
    static func serviceWith(
        feedJSON: String?,
        statusCode: Int = 200,
        error: Error? = nil
    ) -> LocationsService {
        let data = feedJSON?.data(using: .utf8)
        let url = URL(string:PlacesConstants.locationsURL)
        
        let response: URLResponse? = if let url {
            HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )
        } else {
            nil
        }
        
        let sessionResponse: (Data, URLResponse)? = if let data, let response {
            (data, response)
        } else {
            nil
        }
        
        let urlSession = StubIsURLSession(response: sessionResponse, error: error)
        
        return LocationsService(urlSession: urlSession)
    }
}
