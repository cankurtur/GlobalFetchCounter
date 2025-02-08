//
//  CodeFetcherEndpointItem.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import GlobalNetworking

enum CodeFetcherEndpointItem: Endpoint {
    
    case getRoot
    case getResponseCode(_ path: String)
    
    var path: String {
        switch self {
        case .getRoot:
            ""
        case .getResponseCode(let path):
            "/\(path)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoot, .getResponseCode:
            return .get
        }
    }
    
}
