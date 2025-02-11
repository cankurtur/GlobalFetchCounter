//
//  UserDefaultPropertyTests.swift
//  GlobalFetchCounterTests
//
//  Created by Can Kurtur on 11.02.2025.
//

import XCTest
@testable import GlobalFetchCounter

class UserDefaultConfigTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Reset to default value before each test. Different suit name use for Test Cases to avoid changing the real value of the property.
        UserDefaultConfig.fetchCount = 0
    }
    
    override func tearDown() {
        super.setUp()
        // Reset to default value before each test. Different suit name use for Test Cases to avoid changing the real value of the property.
        UserDefaultConfig.fetchCount = 0
    }
    
    func testFetchCount() {
        // Initial value should be the default (0)
        XCTAssertEqual(UserDefaultConfig.fetchCount, 0)
        
        // Set new value
        UserDefaultConfig.fetchCount = 42
        XCTAssertEqual(UserDefaultConfig.fetchCount, 42)
        
        // Reset to different value
        UserDefaultConfig.fetchCount = 10
        XCTAssertEqual(UserDefaultConfig.fetchCount, 10)
    }
    
    func testFetchCountPersistence() {
        // Set value
        UserDefaultConfig.fetchCount = 5
        
        // Value should persist even if we access it multiple times
        XCTAssertEqual(UserDefaultConfig.fetchCount, 5)
        XCTAssertEqual(UserDefaultConfig.fetchCount, 5)
    }
}
