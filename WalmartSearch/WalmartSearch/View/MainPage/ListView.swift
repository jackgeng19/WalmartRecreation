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
                        Text("Results for \"\(vm.searchTerm)\" (\(vm.products.count))")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.leading, -180)
                            .padding(.top, 10)
                            .padding(.bottom, -5)
                    }
                }
                ForEach(vm.products, id: \.id) { product in
                    ProductView(vm: vm, product: product)
                }
            }
        }
    }
}

//#Preview {
//    ListView(vm: ProductViewModel())
//}
