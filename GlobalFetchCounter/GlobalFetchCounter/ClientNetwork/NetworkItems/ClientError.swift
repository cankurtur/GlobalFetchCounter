//
//  ClientError.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

/// Represents client-side API errors.
class ClientError: APIError {
    var error: String
    var statusCode: Int?
}
