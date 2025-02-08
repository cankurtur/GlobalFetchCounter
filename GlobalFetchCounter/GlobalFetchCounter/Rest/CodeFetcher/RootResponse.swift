//
//  RootResponse.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

struct RootResponse: Decodable {
    let nextPath: String?
    
    enum CodingKeys: String, CodingKey {
        case nextPath = "next_path"
    }
}
