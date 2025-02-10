//
//  ClientErrorTests.swift
//  CommonKit
//
//  Created by Can Kurtur on 10.02.2025.
//

import XCTest
@testable import CommonKit

class ClientErrorTests: XCTestCase {
    
    func test_clientError_initialization() {
        // Given
        let errorMessage = "Unauthorized access"
        let statusCode = 401
        
        // When
        let clientError = MockClientError(error: errorMessage, statusCode: statusCode)
        
        // Then
        XCTAssertEqual(clientError.error, errorMessage)
        XCTAssertEqual(clientError.statusCode, statusCode)
    }
    
    func test_client_error_with_nil_status_code() {
        // Given
        let errorMessage = "Bad Request"
        
        // When
        let clientError = MockClientError(error: errorMessage, statusCode: nil)
        
        // Then
        XCTAssertEqual(clientError.error, errorMessage)
        XCTAssertNil(clientError.statusCode)
    }
}
