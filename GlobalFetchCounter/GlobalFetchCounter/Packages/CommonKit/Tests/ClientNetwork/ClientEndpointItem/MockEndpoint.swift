//
//  MockEndpoint.swift
//  CommonKit
//
//  Created by Can Kurtur on 10.02.2025.
//

import CommonKit

public class MockEndpoint: Endpoint {
   
    private let classPath: String
    
    public init(path: String) {
        self.classPath = path
    }
    
    public var path: String {
        return "\(classPath)"
    }
    
    public var baseUrl: String {
        return "http://localhost:8000"
    }

    public var params: [String : Any]? {
        return nil
    }
    
    public var url: String {
        return "\(baseUrl)\(path)"
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var headers: HTTPHeaders? {
        let headers = defaultHeaders
        return headers
    }
}
