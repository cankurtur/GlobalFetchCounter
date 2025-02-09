//
//  ClientError.swift
//  CommonKit
//
//  Created by Can Kurtur on 9.02.2025.
//

import GlobalNetworking

/// Represents client-side API errors.
public class ClientError: APIError {
    public var error: String
    public var statusCode: Int?
}
