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
    private var mockFetchCounterServiceProvider: MockFetchCounterServiceProvider!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockFetchCounterServiceProvider = MockFetchCounterServiceProvider()
        sut = FetchCounterViewModel(fetchCounterServiceProvider: mockFetchCounterServiceProvider)
        cancellables = []
        // Reset to default value before each test. Different suit name use for Test Cases to avoid changing the real value of the property.
        UserDefaultConfig.fetchCount = 0
    }
    
    override func tearDown() {
        super.tearDown()
        mockFetchCounterServiceProvider = nil
        sut = nil
        cancellables = nil
        // Reset to default value after each test. Different suit name use for Test Cases to avoid changing the real value of the property.
        UserDefaultConfig.fetchCount = 0
    }

    func test_fetchButtonTapped_rootPublisher_success() {
        // Given
        let expectedResponse = RootResponse(nextPath: "http://localhost8000")
        mockFetchCounterServiceProvider.mockRootResponse = expectedResponse
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        mockFetchCounterServiceProvider.currentRootResponsePublisher?
            .sink(receiveValue: { rootResponse in
                XCTAssertEqual(expectedResponse.nextPath, rootResponse?.nextPath)
            })
            .store(in: &cancellables)
        
        XCTAssertTrue(mockFetchCounterServiceProvider.isGetRootCalled)
    }
    
    func test_fetchButtonTapped_rootPublisher_failure() {
        // Given
        let expectedError = APIClientError.badRequest
        let expectedMessage = APIClientError.badRequest.message
        mockFetchCounterServiceProvider.mockRootError = expectedError
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        mockFetchCounterServiceProvider.currentAPIClientErrorPublisher?
            .sink(receiveValue: { error in
                XCTAssertEqual(expectedError.statusCode, error?.statusCode)
                XCTAssertEqual(expectedMessage, error?.message)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockFetchCounterServiceProvider.isGetRootCalled)
    }
    
    func test_fetchButtonTapped_responseCodePublisher_success() {
        // Given
        let mockRootResponse = RootResponse(nextPath: "/path")
        mockFetchCounterServiceProvider.mockRootResponse = mockRootResponse
        
        let expectedResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockFetchCounterServiceProvider.mockResponseCodeResponse = expectedResponse
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockFetchCounterServiceProvider.currentResponseCodeResponsePublisher?
            .sink(receiveValue: { responseCodeResponse in
                XCTAssertEqual(expectedResponse.path, responseCodeResponse?.path)
                XCTAssertEqual(expectedResponse.responseCode, responseCodeResponse?.responseCode)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockFetchCounterServiceProvider.isGetResponseCodeCalled)
    }
    
    func test_fetchButtonTapped_responseCodePublisher_failure() {
        // Given
        let mockRootResponse = RootResponse(nextPath: "/path")
        mockFetchCounterServiceProvider.mockRootResponse = mockRootResponse
        
        let expectedError = APIClientError.badRequest
        let expectedMessage = APIClientError.badRequest.message
        mockFetchCounterServiceProvider.mockResponseCodeError = expectedError
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        mockFetchCounterServiceProvider.currentAPIClientErrorPublisher?
            .sink(receiveValue: { error in
                XCTAssertEqual(expectedError.statusCode, error?.statusCode)
                XCTAssertEqual(expectedMessage, error?.message)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockFetchCounterServiceProvider.isGetResponseCodeCalled)
    }
    
    func test_fetchState_rootPublisher_success() {
        // Given
        let expectedResponse = RootResponse(nextPath: "http://localhost8000")
        mockFetchCounterServiceProvider.mockRootResponse = expectedResponse
        
        // When
        sut.fetchButtonTapped()
        
        // Then
        XCTAssertEqual(sut.fetchState, .loading)
        mockFetchCounterServiceProvider.currentRootResponsePublisher?
            .sink(receiveValue: { rootResponse in
                XCTAssertEqual(self.sut.fetchState, .loading)
            })
            .store(in: &cancellables)
    }
    
    func test_fetchState_rootPublisher_failure() {
        // Given
        let mockError = APIClientError.badRequest
        mockFetchCounterServiceProvider.mockRootError = mockError

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
        mockFetchCounterServiceProvider.mockRootResponse = mockRootResponse
        
        let mockResponseCodeResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockFetchCounterServiceProvider.mockResponseCodeResponse = mockResponseCodeResponse
        
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
        mockFetchCounterServiceProvider.mockRootResponse = mockRootResponse
        
        let mockError = APIClientError.badRequest
        mockFetchCounterServiceProvider.mockResponseCodeError = mockError
        
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
        mockFetchCounterServiceProvider.mockRootResponse = mockRootResponse
        
        let mockResponseCodeResponse = ResponseCodeResponse(path: "/path", responseCode: "0000")
        mockFetchCounterServiceProvider.mockResponseCodeResponse = mockResponseCodeResponse
        
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
