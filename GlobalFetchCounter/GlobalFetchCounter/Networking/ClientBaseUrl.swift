//
//  ClientBaseUrl.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

enum ClientBaseUrl: String {
    case baseUrl
    
    var url: String {
        switch self {
        case .baseUrl:
            return "http://localhost:8000"
        }
    }
}
