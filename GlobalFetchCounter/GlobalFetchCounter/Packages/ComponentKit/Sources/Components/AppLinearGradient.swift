//
//  AppLinearGradient.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

/// A custom linear gradient used as a `ShapeStyle` and `View`.
public struct AppLinearGradient: ShapeStyle, View  {
    private let startPoint: UnitPoint
    private let endPoint: UnitPoint
    
    /// Initializer to set the start and end points of the gradient.
    public init(startPoint: UnitPoint = .leading,
         endPoint: UnitPoint = .trailing) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    /// The body of the view that defines the appearance of the gradient.
    public var body: some View {
        LinearGradient(colors: [Color.primaryPurple, Color.primaryRed], startPoint: startPoint , endPoint: endPoint)
    }
    
    /// Resolves the gradient style in the given environment (needed for `ShapeStyle` conformance).
    nonisolated public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(colors: [Color.primaryPurple, Color.primaryRed], startPoint: startPoint , endPoint: endPoint)
    }
}

// MARK: - Preview

#Preview {
    AppLinearGradient()
}
