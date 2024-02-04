//
//  SearchView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State private var showingSheet = false

    var body: some View {
        HStack {
            HStack {
                Button(action: {
                    showingSheet = true
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                        .fontWeight(.light)
                }
                
                TextField("Search", text: $viewModel.searchTerm)
                    .foregroundColor(.primary)
                    .onSubmit {
                        Task {
                            await viewModel.searchProducts()
                        }
                    }
                    .onTapGesture {
                        viewModel.searched = false
                    }
                
                if !viewModel.searchTerm.isEmpty {
                    Button(action: {
                        viewModel.searchTerm = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                
                Text("Sheet content goes here.")
                
            }
            .padding(EdgeInsets(top: 7, leading: 15, bottom: 7, trailing: 5))
            .background(.white)
            .cornerRadius(30.0)
            
        }
        .padding(.horizontal)
    }
}


#Preview {
    SearchView(viewModel: ProductViewModel())
}
