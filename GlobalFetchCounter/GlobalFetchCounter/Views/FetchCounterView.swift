//
//  FetchCounterView.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

struct FetchCounterView: View {
    @StateObject var viewModel = FetchCounterViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 10) {
                Text(Localizable.responseCode)
                    .multilineTextAlignment(.center)
                    .font(.primaryTitle)
                    .foregroundStyle(Color.primaryPurple)
                Text(viewModel.responseCode)
                    .multilineTextAlignment(.center)
                    .font(.primarySubtitle)
                    .foregroundStyle(Color.primaryText)
            }
            .padding()
            VStack(spacing: 10) {
                Text(Localizable.fetchCount)
                    .multilineTextAlignment(.center)
                    .font(.primaryTitle)
                    .foregroundStyle(Color.primaryPurple)
                Text("\(viewModel.fetchCount)")
                    .multilineTextAlignment(.center)
                    .font(.primarySubtitle)
                    .foregroundStyle(Color.primaryText)
            }
            .padding()
            
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
