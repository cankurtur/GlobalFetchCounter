//
//  Localizable.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation

/// A struct that holds localized strings for the module.
struct Localizable {
    static let responseCode = NSLocalizedString("responseCode", bundle: .module, comment: "Response code title for the fetch counter")
    static let fetchCount = NSLocalizedString("fetchCount", bundle: .module, comment: "Fetch count title for the fetch counter")
    static let fetch = NSLocalizedString("fetch", bundle: .module, comment: "Fetch action title")
}
