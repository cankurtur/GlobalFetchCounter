//
//  FetchCounterViewModel.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import Combine

/// The ViewModel for FetchCounterView, responsible for handling the logic and state.
final class FetchCounterViewModel: ObservableObject {
    @Published private(set) var fetchState: FetchState = .initial
    @Published private(set) var fetchCount: Int = UserDefaultConfig.fetchCount
    
    private let fetchCounterServiceProvider: FetchCounterServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchCounterServiceProvider: FetchCounterServiceProtocol = FetcherCounterServiceProvider()) {
        self.fetchCounterServiceProvider = fetchCounterServiceProvider
    }
    
    // Fetch button action.
    func fetchButtonTapped() {
        fetchState = .loading
        
        let rootPublisher = createRootPublisher()
        let responseCodePublisher = createResponseCodePublisher(from: rootPublisher)
        
        responseCodePublisher
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleSuccess)
            .store(in: &cancellables)
    }
}

// MARK: - Privates

private extension FetchCounterViewModel {
    // Creates root publisher. Removes base URL prefix from the path.
    func createRootPublisher() -> AnyPublisher<String, APIClientError> {
        fetchCounterServiceProvider.getRoot()
            .compactMap { $0.nextPath }
            .map { nextPath -> String in
                nextPath.replacingOccurrences(of: Config.shared.baseUrl, with: Localizable.empty)
            }
            .eraseToAnyPublisher()
    }
    
    // Transforms the root path into a response code publisher.
    func createResponseCodePublisher(from rootPublisher: AnyPublisher<String, APIClientError>) -> AnyPublisher<String, APIClientError> {
        rootPublisher
            .flatMap { [weak self] path in
                self?.fetchCounterServiceProvider.getResponseCode(with: path) ?? Empty().eraseToAnyPublisher()
            }
            .compactMap { $0.responseCode }
            .eraseToAnyPublisher()
    }
    
    // Handles the completion of the publisher, updating fetch state if an error occurs.
    func handleCompletion(_ completion: Subscribers.Completion<APIClientError>) {
        switch completion {
        case .failure(let error):
            fetchState = .errorOccured(message: error.message)
        case .finished:
            break
        }
    }
    
    // Updates the view state after successfully fetching a response code.
    func handleSuccess(_ responseCode: String) {
        self.fetchCount.increase()
        UserDefaultConfig.fetchCount.increase()
        self.fetchState = .success(result: responseCode)
    }
}
