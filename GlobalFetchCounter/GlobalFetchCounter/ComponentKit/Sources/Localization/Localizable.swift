//
//  Localizable.swift
//  ComponentKit
//
//  Created by Can Kurtur on 10.02.2025.
//

import Foundation

/// A struct that holds localized strings for the module.
struct Localizable {
    static let warning = NSLocalizedString("warning", bundle: .module, comment: "Warning alert message or cautionary message")
    static let ok = NSLocalizedString("ok", bundle: .module, comment: "OK button title or confirmation action")
    static let empty = NSLocalizedString("empty", bundle: .module, comment: "Empty text for placeholder or label")
}
