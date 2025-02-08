//
//  AppGradientButton.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

public struct AppGradientButton: View {
    private let text: String
    private let action: () -> Void
    private let isLoading: Bool
    
    public init(text: String, action: @escaping () -> Void, isLoading: Bool) {
        self.text = text
        self.action = action
        self.isLoading = isLoading
    }
    
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
                            .foregroundStyle(Color.whiteText)
                            .font(Font.primaryButton)
                            .bold()
                    }
                }
                .frame(height: 60)
        }
        .disabled(isLoading)
    }
}

#Preview {
    AppGradientButton(text: "Text", action: {
        print("Text Tapped")
    }, isLoading: false)
}

