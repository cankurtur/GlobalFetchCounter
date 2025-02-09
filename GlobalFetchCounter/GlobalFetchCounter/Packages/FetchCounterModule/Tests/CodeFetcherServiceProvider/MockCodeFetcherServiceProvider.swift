//
//  MockCodeFetcherServiceProvider.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import XCTest
import Combine
import GlobalNetworking
@testable import FetchCounterModule

final class CodeFetcherServiceProviderTests: XCTestCase {
    
    private var sut: MockCodeFetcherServiceProvider!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = MockCodeFetcherServiceProvider()
        cancellables = []
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
    }
    
    func test_getRoot_success() {
        // Given
        XCTAssertFalse(sut.isGetResponseCodeCalled)
        let expectedResponse = RootResponse(nextPath: "http://localhost8000")
        sut.mockRootResponse = expectedResponse
        
        // When
        var result: RootResponse?
        sut.getRoot()
            .sink { _ in } receiveValue: { rootResponse in
                result = rootResponse
            }
            .store(in: &cancellables)

        // Then
        XCTAssertTrue(sut.isGetRootCalled)
        XCTAssertEqual(expectedResponse.nextPath, result?.nextPath)
    }

    func test_getRoot_failure() {
        // Given
        XCTAssertFalse(sut.isGetResponseCodeCalled)
        let expectedError = APIClientError.badRequest
        sut.mockError = expectedError
        
        // When
        var receievedError: APIClientError?
        sut.getRoot()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receievedError = error
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        // Then
        XCTAssertTrue(sut.isGetRootCalled)
        XCTAssertEqual(expectedError.statusCode, receievedError?.statusCode)
    }
    
    func test_getResponseCode_success() {
        // Given
        XCTAssertFalse(sut.isGetResponseCodeCalled)
        let expectedResponse = ResponseCodeResponse(path: "/path", responseCode: "11223344556677889900")
        sut.mockResponseCodeResponse = expectedResponse
        
        // When
        var result: ResponseCodeResponse?
        sut.getResponseCode(with: "")
            .sink { _ in } receiveValue: { response in
                result = response
            }
            .store(in: &cancellables)

        // Then
        XCTAssertTrue(sut.isGetResponseCodeCalled)
        XCTAssertEqual(expectedResponse.path, result?.path)
        XCTAssertEqual(expectedResponse.responseCode, result?.responseCode)
    }

    func test_getResponseCode_failure() {
        // Given
        XCTAssertFalse(sut.isGetResponseCodeCalled)
        let expectedError = APIClientError.badRequest
        sut.mockError = expectedError
        
        // When
        var receievedError: APIClientError?
        sut.getResponseCode(with: "")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receievedError = error
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        // Then
        XCTAssertTrue(sut.isGetResponseCodeCalled)
        XCTAssertEqual(expectedError.statusCode, receievedError?.statusCode)
    }
}
