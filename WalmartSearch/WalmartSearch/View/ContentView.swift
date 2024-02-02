//
//  ContentView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProductViewModel()

    var body: some View {
        HomeView(vm: viewModel)
            .task {
                await viewModel.fetchAndPrintProducts()
            }
    }
}

#Preview {
    ContentView()
}
