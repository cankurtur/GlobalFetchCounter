//
//  ClientError.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import GlobalNetworking

class ClientError: APIError {
    var error: String
    var statusCode: Int?
}
