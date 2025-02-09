//
//  CompositionRoot.swift
//  CommonKit
//
//  Created by Can Kurtur on 9.02.2025.
//

import Foundation
import GlobalNetworking

/// The protocol that defines the Composition Root's interface.

public protocol CompositionRootProtocol {
    var networkManager: NetworkManagerProtocol { get }
}

/// The actual implementation of the Composition Root. This class provides the concrete dependencies.
public final class CompositionRoot: CompositionRootProtocol {
    nonisolated(unsafe) public static let shared = CompositionRoot()
    
    public lazy var networkManager: NetworkManagerProtocol = {
        return NetworkManager(
            clientErrorType: ClientError.self,
            logger: GlobalNetworking.NetworkLogger()
        )
    }()
  
    private init() { }
}
