//
//  ClientEndpointItem.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import GlobalNetworking

extension Endpoint {
    var baseUrl: String {
        return Config.shared.baseUrl
    }
    
    var params: [String: Any]? {
        return nil
    }
    
    var url: String {
        return "\(baseUrl)\(path)"
    }
    
    var headers: HTTPHeaders? {
        let headers = defaultHeaders
        return headers
    }
}
