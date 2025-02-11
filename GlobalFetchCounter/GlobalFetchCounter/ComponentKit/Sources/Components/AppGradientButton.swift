//
//  AppGradientButton.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

/// A custom gradient button with optional loading state.
public struct AppGradientButton: View {
    private let text: String
    private let action: () -> Void
    private let isLoading: Bool
    
    /// Initializer to set the text, action, and loading state for the button.
    public init(text: String, action: @escaping () -> Void, isLoading: Bool) {
        self.text = text
        self.action = action
        self.isLoading = isLoading
    }
    
    /// The body of the gradient button.
    public var body: some View {
        AppButton {
            action()
        } label: {
            Capsule()
                .fill(AppLinearGradient())
                .overlay {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text(text)
                            .foregroundStyle(AppColor.secondaryText)
                            .font(AppFont.primaryButton)
                            .bold()
                    }
                }
                .frame(height: 60)
        }
        .disabled(isLoading)
    }
}

// MARK: - Preview

#Preview {
    AppGradientButton(text: "Text", action: {
        print("Text Tapped")
    }, isLoading: false)
}
