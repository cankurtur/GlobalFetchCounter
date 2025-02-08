//
//  AppGradientButton.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

struct AppGradientButton: View {
    private let text: String
    private let action: () -> Void
    private let isLoading: Bool
    
    public init(text: String, action: @escaping () -> Void, isLoading: Bool) {
        self.text = text
        self.action = action
        self.isLoading = isLoading
    }
    
    var body: some View {
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
                            .foregroundStyle(.white)
                            .font(.title2)
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
