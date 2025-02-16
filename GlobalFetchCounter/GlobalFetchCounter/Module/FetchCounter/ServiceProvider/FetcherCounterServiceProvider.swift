//
//  FetcherCounterServiceProvider.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import GlobalNetworking

/// A class that fetches data using a network manager.
final class FetcherCounterServiceProvider: FetchCounterServiceProtocol {
    
    // Network manager used to make API requests.
    private let networkManager = NetworkManager<FetchCounterEndpointItem>(clientErrorType: ClientError.self)
    
    func getRoot() async throws -> RootResponse {
        let response = try await networkManager.request(endpoint: .getRoot, responseType: RootResponse.self)
        return response
    }
    
    func getResponseCode(with path: String) async throws -> ResponseCodeResponse {
        let response = try await networkManager.request(endpoint: .getResponseCode(path), responseType: ResponseCodeResponse.self)
        return response
    }
}

