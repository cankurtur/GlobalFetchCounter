//
//  FetchCounterFeature.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 16.02.2025.
//

import SwiftUI
import ComposableArchitecture
import ComponentKit

@Reducer
struct FetchCounterFeature {
 
    @ObservableState
    struct State {
        var responseCode: String = Localizable.empty
        var errorMessage: String = Localizable.empty
        var isLoading: Bool = false
        var isShowError: Bool = false
        var fetchCount = UserDefaultConfig.fetchCount
    }
    
    enum Action {
        case fetchButtonTapped
        case rootResponse(Result<RootResponse, APIClientError>)
        case responseCodeResponse(Result<ResponseCodeResponse, APIClientError>)
        case alertClose(Bool)
    }
    
    private let serviceProvider: FetcherCounterServiceProvider
    
    init(serviceProvider: FetcherCounterServiceProvider = FetcherCounterServiceProvider()) {
        self.serviceProvider = serviceProvider
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchButtonTapped:
                state.isLoading = true
                return .run { send in
                    do {
                        let result = try await serviceProvider.getRoot()
                        await send(.rootResponse(.success(result)))
                    } catch let error as APIClientError {
                        await send(.rootResponse(.failure(error)))
                    }
                }
            case .rootResponse(.success(let response)):
                return .run { send in
                    do {
                        guard let nextPath = response.nextPath else { throw APIClientError.badRequest }
                        let path = nextPath.replacingOccurrences(of: Config.shared.baseUrl, with: Localizable.empty)
                        let response = try await serviceProvider.getResponseCode(with: path)
                        await send(.responseCodeResponse(.success(response)))
                    } catch let error as APIClientError {
                        await send(.responseCodeResponse(.failure(error)))
                    }
                }
            case .rootResponse(.failure(let error)):
                state.isLoading = false
                state.isShowError = true
                state.errorMessage = error.message
                return .none
            
            case .responseCodeResponse(.success(let response)):
                state.isLoading = false
                guard let responseCode = response.responseCode else { return .none }
                state.responseCode = responseCode
                state.fetchCount.increase()
                UserDefaultConfig.fetchCount.increase()
                return .none

            case .responseCodeResponse(.failure(let error)):
                state.isLoading = false
                state.isShowError = true
                state.errorMessage = error.message
                return .none
                
            case .alertClose(let isClose):
                state.isShowError = isClose
                state.errorMessage = Localizable.empty
                return .none
            }
        }
    }
}
