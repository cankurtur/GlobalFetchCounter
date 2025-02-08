//
//  AlertManagerProtocol.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation

protocol AlertManagerProtocol: ObservableObject {
    var isShowing: Bool { get }
    var alertTitle: String { get }
    var alertMessage: String { get }
    
    func presentAlert(title: String, message: String)
    func dismissAlert()
}
