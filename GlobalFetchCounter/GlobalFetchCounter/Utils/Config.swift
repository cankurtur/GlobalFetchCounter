//
//  Config.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 10.02.2025.
//

import Foundation

class Config: NSObject {
    static let shared = Config()
  
    var configs: NSDictionary!
    
    override private init() {
        let currentConfiguration = Bundle.app.object(forInfoDictionaryKey: "Config")!
        let path = Bundle.main.path(forResource: "Config", ofType: "plist")!
        configs = (NSDictionary(contentsOfFile: path)!.object(forKey: currentConfiguration) as! NSDictionary)
    }
}

extension Config {
    
    var baseUrl: String {
        return configs.object(forKey: "baseUrl") as! String
    }
}
