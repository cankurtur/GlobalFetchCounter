//
//  RootResponse.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

// MARK: - RootResponse

struct RootResponse: Decodable {
    let nextPath: String?
    
    enum CodingKeys: String, CodingKey {
        case nextPath = "next_path"
    }
}
