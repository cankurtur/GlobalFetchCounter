//
//  FetchCounterEndpointItem.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

// MARK: - FetchCounterEndpointItem

enum FetchCounterEndpointItem: Endpoint {
    
    case getRoot
    case getResponseCode(_ path: String)
    
    var path: String {
        switch self {
        case .getRoot:
            return Localizable.empty
        case .getResponseCode(let path):
            return path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoot, .getResponseCode:
            return .get
        }
    }
}
