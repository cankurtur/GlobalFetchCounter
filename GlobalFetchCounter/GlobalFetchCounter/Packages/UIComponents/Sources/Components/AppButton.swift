//
//  AppButton.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

public struct AppButton<Label: View>: View {
    var action: () -> Void
    
    @ViewBuilder
    var label: Label
    
    public var body: some View {
        Button {
            action()
        } label: {
            label
        }
    }
}
