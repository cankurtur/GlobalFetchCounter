//
//  FetchCounterView.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import SwiftUI
import ComponentKit

struct FetchCounterView: View {
    @StateObject var viewModel = FetchCounterViewModel()
    @State private var isLoading: Bool = false
    @State private var isShowAlert: Bool = false
    @State private var currentAlertModel: AlertModel?

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
                isLoading: isLoading
            )
        }
        .padding()
        .onReceive(viewModel.$fetchState, perform: { state in
            switch state {
            case .loading:
                isLoading = true
            case .success:
                isLoading = false
            case .errorOccuered(let message):
                isLoading = false
                currentAlertModel = AlertModel(message: message)
                isShowAlert = true
            case .initial:
                break
            }
        })
        .appAlert(isPresented: $isShowAlert, alertModel: currentAlertModel)
    }
}

// MARK: - Preview

#Preview {
    FetchCounterView()
}

