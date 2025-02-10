//
//  FetchCounterViewModel.swift
//  FetchCounterModule
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import Combine
import CommonKit

/// The ViewModel for FetchCounterView, responsible for handling the logic and state.
final class FetchCounterViewModel: ObservableObject {
    @UserDefaultProperty(key: UserDefaultKeys.fetchCount, defaultValue: 0)
    var fetchCount: Int
    
    @Published var responseCode: String = ""
    @Published var fetchState: FetchState = .initial
    
    private let codeFetcherServiceProvider: CodeFetcherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(codeFetcherServiceProvider: CodeFetcherServiceProtocol = CodeFetcherServiceProvider()) {
        self.codeFetcherServiceProvider = codeFetcherServiceProvider
    }
    
    // Function to handle the api request with Combine when the "fetch" button is tapped.
    func fetchButtonTapped() {
        fetchState = .loading
        let rootPublisher = codeFetcherServiceProvider.getRoot()
        
        let codePublisher = rootPublisher
            .compactMap{ $0.nextPath }
            .map { nextPath -> String in
                let path = nextPath.replacingOccurrences(of: Config.baseUrl, with: "")
                return path
            }
            .flatMap { path in
                return self.codeFetcherServiceProvider.getResponseCode(with: path)
            }
        
        codePublisher
            .receive(on: RunLoop.main)
            .compactMap{ $0.responseCode }
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.fetchState = .errorOccuered(message: error.message)
                default:
                    break
                }
            } receiveValue: { responseCode in
                self.responseCode = responseCode
                self.fetchCount += 1
                self.fetchState = .success
            }
            .store(in: &cancellables)
    }
}

