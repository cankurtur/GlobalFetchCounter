//
//  AppButton.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

/// A custom button view that accepts a label and an action.
public struct AppButton<Label: View>: View {
    public var action: () -> Void
    
    @ViewBuilder
    public var label: Label
    
    /// The body of the button, which defines the view layout.
    public var body: some View {
        Button {
            action()
        } label: {
            label
        }
    }
}
