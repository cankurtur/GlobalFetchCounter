//
//  FetchCounterView.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import SwiftUI
import ComponentKit
import ComposableArchitecture

struct FetchCounterView: View {
    @Bindable
    var store: StoreOf<FetchCounterFeature>
    
    var body: some View {
        VStack(spacing: AppPadding.contentPadding) {
            AppDescriptedText(
                title: Localizable.responseCode,
                description: store.responseCode
            )
            
            AppDescriptedText(
                title: Localizable.fetchCount,
                description: String(store.fetchCount)
            )
            
            AppGradientButton(
                text: Localizable.fetch,
                action: {
                    store.send(.fetchButtonTapped)
                },
                isLoading: store.isLoading
            )
        }
        .padding(AppPadding.containerPadding)
        .appAlert(isPresented: $store.isShowError.sending(\.alertClose), alertModel: AlertModel(message: store.errorMessage))
    }
}
