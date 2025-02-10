//
//  CodeFetcherServiceProvider.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import Combine
import CommonKit

/// A class that fetches data using a network manager.
final class CodeFetcherServiceProvider: CodeFetcherServiceProtocol {
    
    // Network manager used to make API requests.
    private let networkManager: NetworkManagerProtocol
    
    // Initializes the service with a network manager.
    init(networkManager: NetworkManagerProtocol = CompositionRoot.shared.networkManager) {
        self.networkManager = networkManager
    }
    
    // Fetches the root response from the API.
    func getRoot() -> AnyPublisher<RootResponse, APIClientError> {
        return networkManager.request(endpoint: CodeFetcherEndpointItem.getRoot, responseType: RootResponse.self)
    }
    
    // Fetches the response code for a specific path.
    func getResponseCode(with path: String) -> AnyPublisher<ResponseCodeResponse, APIClientError> {
        return networkManager.request(endpoint: CodeFetcherEndpointItem.getResponseCode(path), responseType: ResponseCodeResponse.self)
    }
}
