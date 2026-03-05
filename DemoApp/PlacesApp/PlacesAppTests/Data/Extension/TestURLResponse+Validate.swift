//
//  TestURLResponse+Validate.swift
//  PlacesApp
//
//  Created by Sander Korebrits on 05/03/2026.
//

import Testing
import Foundation

@testable import PlacesApp

struct TestURLResponseValidation {
    
    @Test("test returns true when url response is valid")
    func testValidURLResponse() throws {
        let url = try #require(URL(string: "https://example.com"))
        let sut: URLResponse = try #require(HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        ))
        
        #expect(sut.isValidHTTPResponse)
    }
    
    @Test("test returns false when url response is inValid")
    func testInValidURLResponse() throws {
        let url = try #require(URL(string: "https://example.com"))
        let sutA: URLResponse = try #require(HTTPURLResponse(
            url: url,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        ))
        let sutB: URLResponse = .init(
            url: url,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
        
        #expect(!sutA.isValidHTTPResponse)
        #expect(!sutB.isValidHTTPResponse)
    }
}
