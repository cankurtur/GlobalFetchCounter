//
//  FetchCounterViewModel.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import Foundation
import Combine

class FetchCounterViewModel: ObservableObject {
    @Published var responseCode: String = Localizable.empty
    @Published var fetchCount: Int = 0
    @Published var isLoading: Bool = false
    
    private let codeFetcherServiceProvider: CodeFetcherServiceProtocol
    private let fetchCounterDataProvider: FetchCounterDataProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        codeFetcherServiceProvider: CodeFetcherServiceProtocol = CodeFetcherServiceProvider(),
        fetchCounterDataProvider: FetchCounterDataProtocol = FetchCounterDataProvider()
    ) {
        self.codeFetcherServiceProvider = codeFetcherServiceProvider
        self.fetchCounterDataProvider = fetchCounterDataProvider
        setupBindings()
    }
    
    func fetchButtonTapped() {
        isLoading.toggle()
        let rootPublisher = codeFetcherServiceProvider.getRoot()
        
        let codePublisher = rootPublisher
            .compactMap{ $0.nextPath }
            .map { nextPath -> String in
                let baseUrl = Config.shared.baseUrl
                let path = nextPath.replacingOccurrences(of: baseUrl, with: "")
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
                    // TODO: - Alert will added here.
                    print("-----",error.debugMessage)
                    self.isLoading.toggle()
                default:
                    break
                }
            } receiveValue: { responseCode in
                self.responseCode = responseCode
                self.fetchCounterDataProvider.increaseNewCount()
                self.isLoading.toggle()
            }
            .store(in: &cancellables)
    }
    
    func setupBindings() {
        fetchCounterDataProvider.currentCountPublisher
            .assign(to: &$fetchCount)
    }
}
