//
//  URLRespone+Validate.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Foundation

extension URLResponse {

    var isValidHTTPResponse: Bool {
        guard let httpResponse = self as? HTTPURLResponse else {
            return false
        }

        return (200..<300).contains(httpResponse.statusCode)
    }
}
