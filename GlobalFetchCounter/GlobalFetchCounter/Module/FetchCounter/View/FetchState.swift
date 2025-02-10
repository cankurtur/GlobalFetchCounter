//
//  FetchState.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 10.02.2025.
//

import Foundation

/// Enum representing the state of a fetch operation when clicking on fetch button..
enum FetchState<T> {
    /// Initial state before the fetch starts.
    case initial
    /// The fetch is in progress (loading state).
    case loading
    /// An error occurred during the fetch, includes an `message` for error details.
    case errorOccured(message: T)
    /// The fetch was successful.
    case success(result: T)
}
