//
//  CodeFetcherEndpointItemTests.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 10.02.2025.
//

import XCTest
@testable import FetchCounterModule

class CodeFetcherEndpointItemTests: XCTestCase {
    
    func test_getRoot_path() {
        let endpoint = CodeFetcherEndpointItem.getRoot
        XCTAssertEqual(endpoint.path, "")
    }
    
    func test_getRoot_method() {
        let endpoint = CodeFetcherEndpointItem.getRoot
        XCTAssertEqual(endpoint.method, .get)
    }
    
    func test_getResponseCode_path() {
        let testPath = "/test/path"
        let endpoint = CodeFetcherEndpointItem.getResponseCode(testPath)
        XCTAssertEqual(endpoint.path, testPath)
    }
    
    func test_getResponseCode_method() {
        let testPath = "/test/path"
        let endpoint = CodeFetcherEndpointItem.getResponseCode(testPath)
        XCTAssertEqual(endpoint.method, .get)
    }
}
