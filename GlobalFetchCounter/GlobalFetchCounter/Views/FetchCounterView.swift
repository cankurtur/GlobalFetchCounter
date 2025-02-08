//
//  FetchCounterView.swift
//  GlobalFetchCounter
//
//  Created by Can Kurtur on 8.02.2025.
//

import SwiftUI

struct FetchCounterView: View {
    @StateObject var viewModel = FetchCounterViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    FetchCounterView()
}
