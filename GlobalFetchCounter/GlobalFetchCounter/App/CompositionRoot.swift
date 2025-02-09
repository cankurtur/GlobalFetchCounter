//
//  CompositionRoot.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import GlobalNetworking

protocol CompositionRootProtocol {
    var networkManager: NetworkManagerProtocol { get }
}

final class CompositionRoot: CompositionRootProtocol {
    static let shared = CompositionRoot()
    
    lazy var networkManager: NetworkManagerProtocol = {
        return NetworkManager(clientErrorType: ClientError.self, logger: GlobalNetworking.NetworkLogger())
    }()
    
    private init() { }
}
