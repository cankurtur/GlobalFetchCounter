//
//  MockEndpoint.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 10.02.2025.
//

import GlobalNetworking

class MockEndpoint: Endpoint {

    private let classPath: String

    init(path: String) {
        self.classPath = path
    }

    var path: String {
        return "\(classPath)"
    }

    var baseUrl: String {
        return "http://localhost:8000"
    }

    var params: [String : Any]? {
        return nil
    }

    var url: String {
        return "\(baseUrl)\(path)"
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: HTTPHeaders? {
        let headers = defaultHeaders
        return headers
    }
}
