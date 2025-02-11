//
//  FetcherCounterServiceProvider.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import Combine
import GlobalNetworking

/// A class that fetches data using a network manager.
final class FetcherCounterServiceProvider: FetchCounterServiceProtocol {
    
    // Network manager used to make API requests.
    private let networkManager = NetworkManager<FetchCounterEndpointItem>(clientErrorType: ClientError.self)

    // Fetches the root response from the API.
    func getRoot() -> AnyPublisher<RootResponse, APIClientError> {
        return networkManager.request(endpoint: .getRoot, responseType: RootResponse.self)
    }
    
    // Fetches the response code for a specific path.
    func getResponseCode(with path: String) -> AnyPublisher<ResponseCodeResponse, APIClientError> {
        return networkManager.request(endpoint: .getResponseCode(path), responseType: ResponseCodeResponse.self)
    }
}
