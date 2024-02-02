//
//  ContentView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ProductViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            SearchView(viewModel: vm)
        }
        .padding()
        .onAppear {
            Task {
                await vm.fetchAndPrintProducts()
            }
        }
    }
}

#Preview {
    ContentView()
}
