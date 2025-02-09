//
//  ResponseCodeResponse.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

struct ResponseCodeResponse: Decodable {
    let path: String?
    let responseCode: String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case responseCode = "response_code"
    }
    
}
