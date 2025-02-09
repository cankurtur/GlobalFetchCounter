//
//  CodeFetcherServiceProviderTests.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import Combine
import GlobalNetworking
@testable import FetchCounterModule

final class MockCodeFetcherServiceProvider: CodeFetcherServiceProtocol {
    
    var isGetRootCalled = false
    var isGetResponseCodeCalled = false
    
    var mockRootResponse: RootResponse?
    var mockResponseCodeResponse: ResponseCodeResponse?
    var mockError: APIClientError?
  
    var isResponseReceieved: Published<Bool>.Publisher { $receieved }
    @Published private(set) var receieved: Bool = false
    
    func getRoot() -> AnyPublisher<RootResponse, APIClientError> {
        isGetRootCalled = true
        
        if let error = mockError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        guard let response = mockRootResponse else {
          receieved = true
            let defaultResponse = RootResponse(nextPath: "default_next_path")
            return Just(defaultResponse)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        }
        
      
      
        return Just(response)
            .setFailureType(to: APIClientError.self)
            .eraseToAnyPublisher()
    }
    
    func getResponseCode(with path: String) -> AnyPublisher<ResponseCodeResponse, APIClientError> {
        isGetResponseCodeCalled = true
        
        if let error = mockError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        guard let response = mockResponseCodeResponse else {
            let defaultResponse = ResponseCodeResponse(path: "default_path", responseCode: "response_code")
            return Just(defaultResponse)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        }
        
        return Just(response)
            .setFailureType(to: APIClientError.self)
            .eraseToAnyPublisher()
    }
}
