//
//  FetchCounterViewModelTests.swift
//  GlobalFetchCounterTests
//
//  Created by Can Kurtur on 8.02.2025.
//

import XCTest
import Combine
import GlobalNetworking
@testable import GlobalFetchCounter

final class FetchCounterViewModelTests: XCTestCase {
    private var sut: FetchCounterViewModel!
    private var mockCodeFetcherServiceProvider: MockCodeFetcherServiceProvider!
    private var mockAlertManager: MockAlertManager!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockCodeFetcherServiceProvider = MockCodeFetcherServiceProvider()
        mockAlertManager = MockAlertManager()
        sut = FetchCounterViewModel(codeFetcherServiceProvider: mockCodeFetcherServiceProvider, alertManager: mockAlertManager)
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        mockCodeFetcherServiceProvider = nil
        mockAlertManager = nil
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
        var result: RootResponse?
        mockCodeFetcherServiceProvider.getRoot()
            .sink { _ in } receiveValue: { rootResponse in
                result = rootResponse
            }
            .store(in: &cancellables)
        
        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetRootCalled)
        XCTAssertEqual(expectedResponse.nextPath, result?.nextPath)
    }
    
    func test_fetchButtonTapped_rootPublisher_failure() {
        // Given
        let expectedError = APIClientError.badRequest
        let expectedAlertMessage = APIClientError.badRequest.message
        mockCodeFetcherServiceProvider.mockError = expectedError
        XCTAssertFalse(mockCodeFetcherServiceProvider.isGetRootCalled)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        var receievedError: APIClientError?
        mockCodeFetcherServiceProvider.getRoot()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receievedError = error
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetRootCalled)
        XCTAssertEqual(expectedError.statusCode, receievedError?.statusCode)
        XCTAssertEqual(expectedAlertMessage, receievedError?.message)
    }
    
    func test_fetchButtonTapped_codePublisher_success() {
        // Given
        let expectedResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockCodeFetcherServiceProvider.mockResponseCodeResponse = expectedResponse
        XCTAssertFalse(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        var result: ResponseCodeResponse?
        mockCodeFetcherServiceProvider.getResponseCode(with: "" )
            .sink { _ in } receiveValue: { responseCodeResponse in
                result = responseCodeResponse
            }
            .store(in: &cancellables)
        
        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
        XCTAssertEqual(expectedResponse.path, result?.path)
        XCTAssertEqual(expectedResponse.responseCode, result?.responseCode)
    }
    
    func test_fetchButtonTapped_codePublisher_failure() {
        // Given
        let expectedError = APIClientError.badRequest
        let expectedAlertMessage = APIClientError.badRequest.message
        mockCodeFetcherServiceProvider.mockError = expectedError
        XCTAssertFalse(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        var receievedError: APIClientError?
        mockCodeFetcherServiceProvider.getResponseCode(with: "")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receievedError = error
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
        XCTAssertEqual(expectedError.statusCode, receievedError?.statusCode)
        XCTAssertEqual(expectedAlertMessage, receievedError?.message)
    }
}
