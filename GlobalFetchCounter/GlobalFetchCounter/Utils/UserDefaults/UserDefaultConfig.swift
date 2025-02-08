//
//  UserDefaultConfig.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation

/// When a new property is added for UserDefaults, this enum should be written as a case.
enum UserDefaultKeys: String {
    case fetchCount
}

struct UserDefaultConfig {
    @UserDefaultProperty(key: UserDefaultKeys.fetchCount, defaultValue: 0)
    static var fetchCount: Int
}
