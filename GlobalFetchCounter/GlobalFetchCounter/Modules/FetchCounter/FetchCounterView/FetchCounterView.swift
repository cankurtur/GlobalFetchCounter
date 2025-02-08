//
//  FetchCounterView.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI
import UIComponents

struct FetchCounterView: View {
    @StateObject var viewModel = FetchCounterViewModel()
    
    var body: some View {
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
        .ignoresSafeArea()
    }
}

#Preview {
    FetchCounterView()
}
