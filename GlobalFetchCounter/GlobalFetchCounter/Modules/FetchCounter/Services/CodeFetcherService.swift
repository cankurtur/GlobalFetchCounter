//
//  CodeFetcherService.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation
import Combine
import GlobalNetworking

protocol CodeFetcherServiceProtocol {
    func getRoot() -> AnyPublisher<RootResponse, APIClientError>
    func getResponseCode(with path: String) -> AnyPublisher<ResponseCodeResponse, APIClientError>
}

final class CodeFetcherServiceProvider: CodeFetcherServiceProtocol {
    private let networkManager: NetworkManager<CodeFetcherEndpointItem>
    
    init() {
        networkManager = NetworkManager<CodeFetcherEndpointItem>(clientErrorType: ClientError.self, logger: NetworkLogger())
    }
    
    func getRoot() -> AnyPublisher<RootResponse, APIClientError> {
        return networkManager.request(endpoint: .getRoot, responseType: RootResponse.self)
    }
    
    func getResponseCode(with path: String) -> AnyPublisher<ResponseCodeResponse, APIClientError> {
        return networkManager.request(endpoint: .getResponseCode(path), responseType: ResponseCodeResponse.self)
    }
}
