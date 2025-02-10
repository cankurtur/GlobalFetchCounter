//
//  MockClientError.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 10.02.2025.
//

import GlobalNetworking

final class MockClientError: APIError {
    var error: String
    var statusCode: Int?
    
    init(error: String, statusCode: Int?) {
        self.error = error
        self.statusCode = statusCode
    }
}
