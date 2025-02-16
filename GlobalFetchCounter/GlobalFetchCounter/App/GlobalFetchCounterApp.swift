//
//  GlobalFetchCounterApp.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct GlobalFetchCounterApp: App {
    var body: some Scene {
        WindowGroup {
            FetchCounterView(
                store: Store(initialState: FetchCounterFeature.State(), reducer: {
                    FetchCounterFeature()
                })
            )
        }
    }
}
