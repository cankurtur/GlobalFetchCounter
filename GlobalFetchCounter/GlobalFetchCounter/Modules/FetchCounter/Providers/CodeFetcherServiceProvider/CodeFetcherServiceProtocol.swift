//
//  CodeFetcherServiceProtocol.swift
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
