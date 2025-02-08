//
//  FetchCounterDataProvider.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation
import Combine

class FetchCounterDataProvider: FetchCounterDataProtocol {
    @Published private var currentCount: Int = UserDefaultConfig.fetchCount
    
    var currentCountPublisher: AnyPublisher<Int, Never> {
        $currentCount.eraseToAnyPublisher()
    }
    
    func increaseNewCount() {
        UserDefaultConfig.fetchCount += 1
        currentCount = UserDefaultConfig.fetchCount
    }
}

