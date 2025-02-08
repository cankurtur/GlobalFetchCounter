//
//  AlertManager.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation

final class AlertManager: AlertManagerProtocol {
    @Published var isShowing: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    static let shared = AlertManager()
    
    private init() { }
    
    func presentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isShowing = true
    }
    
    func dismissAlert() {
        isShowing = false
    }
}
