//
//  AlertModifier.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @ObservedObject var alertManager = AlertManager.shared
    
    func body(content: Content) -> some View {
        content
            .alert(
                alertManager.alertTitle,
                isPresented: $alertManager.isShowing
            ) {
                Button(Localizable.ok) {
                    alertManager.dismissAlert()
                }
            } message: {
                Text(alertManager.alertMessage)
            }
    }
}

