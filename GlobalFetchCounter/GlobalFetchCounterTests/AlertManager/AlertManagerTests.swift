//
//  AlertManagerTests.swift
//  GlobalFetchCounterTests
//
//  Created by Can Kurtur on 9.02.2025.
//

import XCTest
@testable import GlobalFetchCounter

final class AlertManagerTests: XCTestCase {

    private var sut: MockAlertManager!
    
    override func setUp() {
        super.setUp()
        sut = MockAlertManager()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_showAlert_success() {
        // Given
        XCTAssertFalse(sut.isPresentAlertCalled)
        
        let expectedTitle = "Test Title"
        let expectedMessage = "Test Message"
        let expectedIsShowing = true
        
        // When
        sut.presentAlert(title: expectedTitle, message: expectedMessage)
        
        // Then
        
        let alertTitle = sut.alertTitle
        let alertMessage = sut.alertMessage
        let isShowingAlert = sut.isShowing
        
        XCTAssertTrue(sut.isPresentAlertCalled)
        XCTAssertEqual(expectedTitle, alertTitle)
        XCTAssertEqual(expectedMessage, alertMessage)
        XCTAssertEqual(expectedIsShowing, isShowingAlert)
    }

    func test_dismissAlert_success() {
        // Given
        XCTAssertFalse(sut.isDismissAlertCalled)
        let expectedIsShowing = false
        
        // When
        sut.dismissAlert()
        
        // Then
        let isShowingAlert = sut.isShowing
        XCTAssertTrue(sut.isDismissAlertCalled)
        XCTAssertEqual(expectedIsShowing, isShowingAlert)
    }
}
