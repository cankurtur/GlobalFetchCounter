//
//  ClientEndpointItem.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

/// Default configuration for client API endpoints.
extension Endpoint {
    
    /// Base URL for the API. Ensure this is set properly in the implementation.
    var baseUrl: String {
        return Config.shared.baseUrl
    }
    
    /// Query parameters for the request (optional).
    var params: [String: Any]? {
        return nil
    }
    
    /// Full URL constructed using `baseUrl` and `path`.
    var url: String {
        return baseUrl + path
    }
    
    /// Default HTTP headers for the request.
    var headers: HTTPHeaders? {
        let headers = defaultHeaders
        return headers
    }
}
