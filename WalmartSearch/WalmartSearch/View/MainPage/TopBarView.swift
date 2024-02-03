//
//  TopBarView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct TopBarView: View {
    @ObservedObject var vm: ProductViewModel
    @State private var showingCart = false // Added for cart view presentation


    var body: some View {
        VStack {
            HStack{
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .padding(.leading, 18)
                    .fontWeight(.bold)

                SearchView(viewModel: vm)
                
                Button(action: {
                    showingCart.toggle() // Toggle the state to show cart
                }) {
                    ZStack {
                        Image(systemName: "cart")
                            .foregroundColor(.white)
                            .padding(.trailing, 17)
                            .fontWeight(.bold)
                        if !vm.cart.isEmpty {
                            Text("\(vm.cart.count)")
                                .font(.caption2)
                                .padding(5)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: -20, y: -10)
                        }
                    }
                }
            }
            .padding(.top, 11)
            .padding(.bottom, 7)
            .padding(.trailing, 1)
            HStack {
                Image(systemName: "head.profile.arrow.forward.and.visionpro")
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                Spacer()
                
                Text("How do you want your items? |27517")
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .padding(.leading, -10)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                    .padding(.trailing, 18)
            }
            .padding(.bottom, 7)
        }
        .background(.blue)
        .sheet(isPresented: $showingCart) {
            CartView(viewModel: vm) // Present the cart view
        }
    }
}

#Preview {
    TopBarView(vm: ProductViewModel())
}
