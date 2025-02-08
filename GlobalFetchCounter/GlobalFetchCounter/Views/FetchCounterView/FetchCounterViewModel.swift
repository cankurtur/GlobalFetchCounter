//
//  FetchCounterViewModel.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation

final class FetchCounterViewModel: ObservableObject {
    @Published var responseCode: String = Localizable.empty
    @Published var fetchCount: Int = 0
    
    func fetchButtonTapped() {
        //TODO: Implement api call here
    }
}
