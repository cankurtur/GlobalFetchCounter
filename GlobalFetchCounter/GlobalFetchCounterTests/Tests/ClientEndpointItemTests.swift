//
//  ClientEndpointItemTests.swift
//  GlobalFetchCounterTests
//
//  Created by Can Kurtur on 11.02.2025.
//

import XCTest
@testable import GlobalFetchCounter

// Test Class
class ClientEndpointTests: XCTestCase {
    
    func test_base_url() {
        // Given
        let endpoint = MockEndpointItem(path: "/testPath")
        
        // When
        let baseUrl = endpoint.baseUrl
        
        // Then
        XCTAssertEqual(baseUrl, "http://localhost:8000")
    }
    
    func test_params() {
        // Given
        let endpoint = MockEndpointItem(path: "/testPath")
        
        // When
        let params = endpoint.params
        
        // Then
        XCTAssertNil(params)
    }
    
    func test_url() {
        // Given
        let endpoint = MockEndpointItem(path: "/testPath")
        
        // When
        let url = endpoint.url
        
        // Then
        XCTAssertEqual(url, "http://localhost:8000/testPath")
    }
    
    func test_headers() {
        // Given
        let endpoint = MockEndpointItem(path: "/testPath")
        
        // When
        let headers = endpoint.headers
        
        // Then
        XCTAssertNotNil(headers)
    }
}

// Mock class.
class MockEndpointItem: Endpoint {
    private let classPath: String
    
    public init(path: String) {
        self.classPath = path
    }

    var path: String {
        return classPath
    }
    
    var method: HTTPMethod {
        return .get
    }
}
