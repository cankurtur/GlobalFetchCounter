//
//  MockAlertManager.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
@testable import GlobalFetchCounter

final class MockAlertManager: AlertManagerProtocol {
    
    var isPresentAlertCalled: Bool = false
    var isDismissAlertCalled: Bool = false
    
    var isShowing: Bool = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    func presentAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        isShowing = true
        
        isPresentAlertCalled = true
    }
    
    func dismissAlert() {
        isDismissAlertCalled = true
    }
}
