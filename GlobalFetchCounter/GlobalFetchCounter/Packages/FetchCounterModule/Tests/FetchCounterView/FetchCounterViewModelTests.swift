//
//  FetchCounterViewModelTests.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import XCTest
import Combine
import GlobalNetworking
import CommonKit
@testable import FetchCounterModule

final class FetchCounterViewModelTests: XCTestCase {
    private var sut: FetchCounterViewModel!
    private var mockCodeFetcherServiceProvider: MockCodeFetcherServiceProvider!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockCodeFetcherServiceProvider = MockCodeFetcherServiceProvider()
        sut = FetchCounterViewModel(codeFetcherServiceProvider: mockCodeFetcherServiceProvider)
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        mockCodeFetcherServiceProvider = nil
        sut = nil
        cancellables = nil
    }

    func test_fetchButtonTapped_rootPublisher_success() {
        // Given
        let expectedResponse = RootResponse(nextPath: "http://localhost8000")
        mockCodeFetcherServiceProvider.mockRootResponse = expectedResponse
        XCTAssertFalse(mockCodeFetcherServiceProvider.isGetRootCalled)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockCodeFetcherServiceProvider.currentRootResponsePublisher?
            .sink(receiveValue: { rootResponse in
                XCTAssertEqual(expectedResponse.nextPath, rootResponse?.nextPath)
            })
            .store(in: &cancellables)
        
        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetRootCalled)
    }
    
    func test_fetchButtonTapped_rootPublisher_failure() {
        // Given
        let expectedError = APIClientError.badRequest
        let expectedAlertMessage = APIClientError.badRequest.message
        mockCodeFetcherServiceProvider.mockRootError = expectedError
        XCTAssertFalse(mockCodeFetcherServiceProvider.isGetRootCalled)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockCodeFetcherServiceProvider.currentAPIClientErrorPublisher?
            .sink(receiveValue: { error in
                XCTAssertEqual(expectedError.statusCode, error?.statusCode)
                XCTAssertEqual(expectedAlertMessage, error?.message)
            })

            .store(in: &cancellables)
        
        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetRootCalled)
    }
    
    func test_fetchButtonTapped_codePublisher_success() {
        // Given
        let expectedResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockCodeFetcherServiceProvider.mockResponseCodeResponse = expectedResponse
        XCTAssertFalse(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockCodeFetcherServiceProvider.currentResponseCodeResponsePublisher?
            .sink(receiveValue: { responseCode in
                XCTAssertEqual(expectedResponse.path, responseCode?.path)
                XCTAssertEqual(expectedResponse.responseCode, responseCode?.responseCode)
            })
            .store(in: &cancellables)

        
        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
    }
    
    func test_fetchButtonTapped_codePublisher_failure() {
        // Given
        let expectedError = APIClientError.badRequest
        let expectedAlertMessage = APIClientError.badRequest.message
        mockCodeFetcherServiceProvider.mockResponseCodeError = expectedError
        XCTAssertFalse(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockCodeFetcherServiceProvider.currentAPIClientErrorPublisher?
            .dropFirst()
            .sink(receiveValue: { error in
                XCTAssertEqual(expectedError.statusCode, error?.statusCode)
                XCTAssertEqual(expectedAlertMessage, error?.message)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
    }
}
