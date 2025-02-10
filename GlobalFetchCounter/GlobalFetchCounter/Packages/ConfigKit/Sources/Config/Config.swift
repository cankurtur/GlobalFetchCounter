//
//  Config.swift
//  ConfigKit
//
//  Created by Can Kurtur on 10.02.2025.
//

import Foundation

/// A singleton instance of `Config`, keeping user config informations.
public struct Config: Sendable {
    private static let shared = Config()
    
    private var dict: [String: String] = [:]
    
    private init() {
      let url = Bundle.module.url(forResource: "Config", withExtension: "plist")
      let data = try! Data(contentsOf: url!)
      
      guard let plist = try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] else {
        return
      }
      
      #if DEBUG
      dict = plist["Debug"] as? [String: String] ?? [:]
      #else
      dict = plist["Release"] as? [String: String] ?? [:]
      #endif
    }
}

// MARK: - Extension

/// Plist values.
public extension Config {
    static var baseUrl: String {
      return Config.shared.dict["baseUrl"]!
    }
}
