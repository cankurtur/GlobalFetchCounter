//
//  CodeFetcherServiceProvider.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation
import Combine
import GlobalNetworking

final class CodeFetcherServiceProvider: CodeFetcherServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = CompositionRoot.shared.networkManager) {
        self.networkManager = networkManager
    }
    
    func getRoot() -> AnyPublisher<RootResponse, APIClientError> {
        return networkManager.request(endpoint: CodeFetcherEndpointItem.getRoot, responseType: RootResponse.self)
    }
    
    func getResponseCode(with path: String) -> AnyPublisher<ResponseCodeResponse, APIClientError> {
        return networkManager.request(endpoint: CodeFetcherEndpointItem.getResponseCode(path), responseType: ResponseCodeResponse.self)
    }
}
