//
//  ListView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var vm: ProductViewModel

    var body: some View {
        ScrollView {
            VStack {
                if !vm.searchTerm.isEmpty && vm.searched {
                    HStack {
                        if vm.products.isEmpty {
                            // Display a message when no products are found
                            Text("Oops, there seems no results for \"\(vm.searchTerm)\"")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding()
                                .multilineTextAlignment(.center) // Center align the text
                        } else {
                            // Display search results count
                            Text("Results for \"\(vm.searchTerm)\" (\(vm.products.count))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.top, 10)
                        }
                    }
                }
                ForEach(vm.products, id: \.id) { product in
                    ProductView(vm: vm, product: product)
                }
            }
        }
    }
}

#Preview {
    ListView(vm: ProductViewModel())
}
