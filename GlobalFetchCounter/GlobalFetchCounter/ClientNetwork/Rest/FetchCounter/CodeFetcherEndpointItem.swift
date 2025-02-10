//
//  CodeFetcherEndpointItem.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

// MARK: - CodeFetcherEndpointItem

enum CodeFetcherEndpointItem: Endpoint {
    
    case getRoot
    case getResponseCode(_ path: String)
    
    var path: String {
        switch self {
        case .getRoot:
            ""
        case .getResponseCode(let path):
            "\(path)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoot, .getResponseCode:
            return .get
        }
    }
}
