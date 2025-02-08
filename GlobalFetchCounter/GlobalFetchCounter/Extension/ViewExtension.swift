//
//  ViewExtension.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 9.02.2025.
//

import SwiftUI

extension View {
    func appAlert() -> some View {
        self.modifier(AlertModifier())
    }
}
