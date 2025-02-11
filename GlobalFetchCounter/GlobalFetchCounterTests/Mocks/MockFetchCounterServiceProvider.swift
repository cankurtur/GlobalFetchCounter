//
//  MockFetchCounterServiceProvider.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 11.02.2025.
//

import Foundation
import Combine
@testable import GlobalFetchCounter

final class MockFetchCounterServiceProvider: FetchCounterServiceProtocol {
    
    var currentRootResponsePublisher: Published<RootResponse?>.Publisher? { $currentRootResponse }
    @Published private(set) var currentRootResponse: RootResponse?
    
    var currentResponseCodeResponsePublisher: Published<ResponseCodeResponse?>.Publisher? { $currentResponseCodeResponse }
    @Published private(set) var currentResponseCodeResponse: ResponseCodeResponse?
    
    var currentAPIClientErrorPublisher: Published<APIClientError?>.Publisher? { $currentApiClientError }
    @Published private(set) var currentApiClientError: APIClientError?

    var isGetRootCalled = false
    var isGetResponseCodeCalled = false
    
    var mockRootResponse: RootResponse?
    var mockResponseCodeResponse: ResponseCodeResponse?
    var mockRootError: APIClientError?
    var mockResponseCodeError: APIClientError?
    
    func getRoot() -> AnyPublisher<RootResponse, APIClientError> {
        isGetRootCalled = true
        
        if let error = mockRootError {
            currentApiClientError = error
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        guard let response = mockRootResponse else {
            let defaultResponse = RootResponse(nextPath: "default_next_path")
            return Just(defaultResponse)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        }
        
        currentRootResponse = response
        return Just(response)
            .setFailureType(to: APIClientError.self)
            .eraseToAnyPublisher()
    }
    
    func getResponseCode(with path: String) -> AnyPublisher<ResponseCodeResponse, APIClientError> {
        isGetResponseCodeCalled = true
        
        if let error = mockResponseCodeError {
            currentApiClientError = error
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        guard let response = mockResponseCodeResponse else {
            let defaultResponse = ResponseCodeResponse(path: "default_path", responseCode: "response_code")
            return Just(defaultResponse)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        }
        
        currentResponseCodeResponse = response
        return Just(response)
            .setFailureType(to: APIClientError.self)
            .eraseToAnyPublisher()
    }
}
