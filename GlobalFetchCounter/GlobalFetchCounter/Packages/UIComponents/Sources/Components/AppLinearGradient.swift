//
//  AppLinearGradient.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

public struct AppLinearGradient: ShapeStyle, View  {
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    
    public init(startPoint: UnitPoint = .leading,
         endPoint: UnitPoint = .trailing) {
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    public var body: some View {
        LinearGradient(colors: [Color.primaryPurple, Color.primaryRed], startPoint: startPoint , endPoint: endPoint)
    }
    
    nonisolated public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(colors: [Color.primaryPurple, Color.primaryRed], startPoint: startPoint , endPoint: endPoint)
    }
}

// MARK: - Preview
#Preview {
    AppLinearGradient()
}
