//
//  SwiftUIView.swift
//  ComponentKit
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

/// A view that displays a title and a description with custom styling.
public struct AppDescriptedText: View {
    private let title: String
    private let description: String
    
    /// Initializer to set the title and description values.
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    /// The body of the view, which defines the layout and appearance of the title and description.
    public var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .multilineTextAlignment(.center)
                .font(Font.primaryTitle)
                .foregroundStyle(Color.primaryPurple)
            Text(description)
                .multilineTextAlignment(.center)
                .font(Font.primarySubtitle)
                .foregroundStyle(Color.primaryText)
        }
    }
}

// MARK: - Preview

#Preview {
    AppDescriptedText(title: "Text", description: "Description")
}
