//
//  AlertManagerProtocol.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation

protocol AlertManagerProtocol: ObservableObject {
    var isShowing: Bool { get set }
    var alertTitle: String { get set }
    var alertMessage: String { get set }
    
    func presentAlert(title: String, message: String)
    func dismissAlert()
}
