//
//  MockClientError.swift
//  CommonKit
//
//  Created by Can Kurtur on 10.02.2025.
//

import GlobalNetworking

final class MockClientError: APIError {
    public var error: String
    public var statusCode: Int?
    
    public init(error: String, statusCode: Int?) {
        self.error = error
        self.statusCode = statusCode
    }
}
