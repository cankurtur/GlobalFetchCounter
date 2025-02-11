//
//  FetchCounterViewModelTests.swift
//  GlobalFetchCounterTests
//
//  Created by Can Kurtur on 11.02.2025.
//

import XCTest
import Combine
@testable import GlobalFetchCounter

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
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
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
        let expectedMessage = APIClientError.badRequest.message
        mockCodeFetcherServiceProvider.mockRootError = expectedError
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        mockCodeFetcherServiceProvider.currentAPIClientErrorPublisher?
            .sink(receiveValue: { error in
                XCTAssertEqual(expectedError.statusCode, error?.statusCode)
                XCTAssertEqual(expectedMessage, error?.message)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetRootCalled)
    }
    
    func test_fetchButtonTapped_responseCodePublisher_success() {
        // Given
        let mockRootResponse = RootResponse(nextPath: "/path")
        mockCodeFetcherServiceProvider.mockRootResponse = mockRootResponse
        
        let expectedResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockCodeFetcherServiceProvider.mockResponseCodeResponse = expectedResponse
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockCodeFetcherServiceProvider.currentResponseCodeResponsePublisher?
            .sink(receiveValue: { responseCodeResponse in
                XCTAssertEqual(expectedResponse.path, responseCodeResponse?.path)
                XCTAssertEqual(expectedResponse.responseCode, responseCodeResponse?.responseCode)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
    }
    
    func test_fetchButtonTapped_responseCodePublisher_failure() {
        // Given
        let mockRootResponse = RootResponse(nextPath: "/path")
        mockCodeFetcherServiceProvider.mockRootResponse = mockRootResponse
        
        let expectedError = APIClientError.badRequest
        let expectedMessage = APIClientError.badRequest.message
        mockCodeFetcherServiceProvider.mockResponseCodeError = expectedError
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockCodeFetcherServiceProvider.currentAPIClientErrorPublisher?
            .sink(receiveValue: { error in
                XCTAssertEqual(expectedError.statusCode, error?.statusCode)
                XCTAssertEqual(expectedMessage, error?.message)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockCodeFetcherServiceProvider.isGetResponseCodeCalled)
    }
    
    func test_fetchState_rootPublisher_success() {
        // Given
        let expectedResponse = RootResponse(nextPath: "http://localhost8000")
        mockCodeFetcherServiceProvider.mockRootResponse = expectedResponse
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        mockCodeFetcherServiceProvider.currentRootResponsePublisher?
            .sink(receiveValue: { rootResponse in
                XCTAssertEqual(self.sut.fetchState, .loading)
            })
            .store(in: &cancellables)
    }
    
    func test_fetchState_rootPublisher_failure() {
        // Given
        let mockError = APIClientError.badRequest
        mockCodeFetcherServiceProvider.mockRootError = mockError

        let expectedMessage = APIClientError.badRequest.message
        let stateChangeExpectation = expectation(description: "State should change to error")

        sut.$fetchState
            .dropFirst(2) // Initial and Loading states dropped.
            .sink { state in
                if case .errorOccured(let message) = state {
                    XCTAssertEqual(message, expectedMessage)
                    stateChangeExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        wait(for: [stateChangeExpectation], timeout: 1)
    }
    
    func test_fetchState_responseCodePublisher_success() {
        // Given
        let mockRootResponse = RootResponse(nextPath: "http://localhost8000")
        mockCodeFetcherServiceProvider.mockRootResponse = mockRootResponse
        
        let mockResponseCodeResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockCodeFetcherServiceProvider.mockResponseCodeResponse = mockResponseCodeResponse
        
        let expectedResult = "0000"
        let stateChangeExpectation = expectation(description: "State should change to success")

        sut.$fetchState
            .dropFirst(2) // Initial and Loading states dropped.
            .sink { state in
                if case .success(let result) = state {
                    XCTAssertEqual(result, expectedResult)
                    stateChangeExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        wait(for: [stateChangeExpectation], timeout: 1)
    }
    
    func test_fetchState_responseCodePublisher_failure() {
        // Given
        let mockRootResponse = RootResponse(nextPath: "http://localhost8000")
        mockCodeFetcherServiceProvider.mockRootResponse = mockRootResponse
        
        let mockError = APIClientError.badRequest
        mockCodeFetcherServiceProvider.mockResponseCodeError = mockError
        
        let expectedMessage = APIClientError.badRequest.message
        let stateChangeExpectation = expectation(description: "State should change to error")

        sut.$fetchState
            .dropFirst(2) // Initial and Loading states dropped.
            .sink { state in
                if case .errorOccured(let message) = state {
                    XCTAssertEqual(message, expectedMessage)
                    stateChangeExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        wait(for: [stateChangeExpectation], timeout: 1)
    }
    
    func test_fetchCount() {
        // Given
        let mockRootResponse = RootResponse(nextPath: "/path")
        mockCodeFetcherServiceProvider.mockRootResponse = mockRootResponse
        
        let mockResponseCodeResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockCodeFetcherServiceProvider.mockResponseCodeResponse = mockResponseCodeResponse
        
        let expectedResult = 1
        let fetchCountExpectation = expectation(description: "Fetch count should increase 1")

        sut.$fetchState
            .dropFirst(2) // Initial and Loading states dropped.
            .sink { state in
                if case .success = state {
                    XCTAssertEqual(self.sut.fetchCount, expectedResult)
                    fetchCountExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        wait(for: [fetchCountExpectation], timeout: 1)
    }
}
