//
//  AppButton.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

struct AppButton<Label: View>: View {
    var action: () -> Void
    
    @ViewBuilder
    var label: Label
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
    }
}
