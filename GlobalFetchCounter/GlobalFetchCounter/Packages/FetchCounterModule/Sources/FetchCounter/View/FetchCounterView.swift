//
//  FetchCounterView.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import SwiftUI
import UIComponents

/// This module fetches a response codes and keeps the count value inside UserDefaults.
public struct FetchCounterView: View {
    @StateObject var viewModel = FetchCounterViewModel()
    
    /// The initializer doesn't need any special setup when the view is created.
    public init() { }
    
    /// The body of the view that defines its layout and behavior.
    public var body: some View {
        VStack(spacing: 10) {
            AppDescriptedText(
                title: Localizable.responseCode,
                description: viewModel.responseCode
            )
            
            AppDescriptedText(
                title: Localizable.fetchCount,
                description: String(viewModel.fetchCount)
            )
            
            AppGradientButton(
                text: Localizable.fetch,
                action: {
                    viewModel.fetchButtonTapped()
                },
                isLoading: false
            )
        }
        .padding()
        .alert(
          Localizable.warning,
          isPresented: $viewModel.isErrorOccored
        ) {
            Button("OK") { }
        } message: {
          Text(viewModel.errorMessage)
        }
    }
}

// MARK: - Preview

#Preview {
    FetchCounterView()
}
