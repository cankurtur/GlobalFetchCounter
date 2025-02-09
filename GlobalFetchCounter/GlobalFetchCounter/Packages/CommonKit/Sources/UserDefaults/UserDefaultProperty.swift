//
//  UserDefaultProperty.swift
//  CommonKit
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation

/// A property wrapper that allows storing `Codable` values in `UserDefaults`.
@propertyWrapper
public struct UserDefaultProperty<Value: Codable> {
    private let key: UserDefaultKeys
    private let defaultValue: Value
    private let userDefaults: UserDefaults
    
    public init(key: UserDefaultKeys, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
        
        if NSClassFromString("XCTestCase") != nil {
            userDefaults = UserDefaults(suiteName: #file) ?? .standard
            userDefaults.removePersistentDomain(forName: #file)
        } else {
            userDefaults = .standard
        }
    }
    
    /// The wrapped value property to get and set values in UserDefaults.
    public var wrappedValue: Value {
        get {
            guard let data = userDefaults.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: key.rawValue)
            userDefaults.synchronize()
        }
    }
}

/// Convenience initializer for optional values
public extension UserDefaultProperty where Value: ExpressibleByNilLiteral {
    init(key: UserDefaultKeys) {
        self.init(key: key, defaultValue: nil)
    }
}

