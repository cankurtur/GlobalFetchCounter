//
//  ClientEndpointTests.swift
//  GlobalFetchCounterTests
//
//  Created by Can Kurtur on 10.02.2025.
//

import XCTest
@testable import GlobalFetchCounter

class ClientEndpointTests: XCTestCase {

    func test_path() {
        // Given
        let endpoint = MockEndpoint(path: "/testPath")

        // When
        let path = endpoint.path

        // Then
        XCTAssertEqual(path, "/testPath")
    }

    func test_base_url() {
        // Given
        let endpoint = MockEndpoint(path: "/testPath")

        // When
        let baseUrl = endpoint.baseUrl

        // Then
        XCTAssertEqual(baseUrl, "http://localhost:8000")
    }

    func test_params() {
        // Given
        let endpoint = MockEndpoint(path: "/testPath")

        // When
        let params = endpoint.params

        // Then
        XCTAssertNil(params)
    }

    func test_url() {
        // Given
        let endpoint = MockEndpoint(path: "/testPath")

        // When
        let url = endpoint.url

        // Then
        XCTAssertEqual(url, "http://localhost:8000/testPath")
    }

    func test_method() {
        // Given
        let endpoint = MockEndpoint(path: "/testPath")

        // When

        let method = endpoint.method

        // Then
        XCTAssertEqual(method, .get)
    }
    func test_headers() {
        // Given
        let endpoint = MockEndpoint(path: "/testPath")

        // When
        let headers = endpoint.headers

        // Then
        XCTAssertNotNil(headers)
    }
}
