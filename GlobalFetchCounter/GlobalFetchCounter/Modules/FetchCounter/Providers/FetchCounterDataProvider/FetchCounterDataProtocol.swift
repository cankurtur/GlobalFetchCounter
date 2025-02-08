//
//  FetchCounterDataProtocol.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation
import Combine

protocol FetchCounterDataProtocol {
    var currentCountPublisher: AnyPublisher<Int, Never> { get }
    func increaseNewCount()
}
