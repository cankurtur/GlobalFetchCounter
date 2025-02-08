//
//  SwiftUIView.swift
//  UIComponents
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

public struct AppDescriptedText: View {
    private let title: String
    private let description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
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

#Preview {
    AppDescriptedText(title: "Text", description: "Description")
}
