//
//  HomeView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm: ProductViewModel

    var body: some View {
        VStack {
            TopBarView(vm: vm)
            ListView(vm: vm)
                .padding(.top, -7)
        }
        TabView()
    }
}

#Preview {
    HomeView(vm: ProductViewModel())
}
