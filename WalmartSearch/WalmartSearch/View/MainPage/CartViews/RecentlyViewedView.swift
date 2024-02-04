//
//  RecentlyViewedView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/3/24.
//

import SwiftUI


struct RecentlyViewedView: View {
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.recentlyViewed, id: \.id) { product in
                        NavigationLink(destination: ProductDetailView(vm: viewModel, product: product)) {
                            HStack {
                                AsyncImage(url: URL(string: product.thumbnail)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                                
                                VStack(alignment: .leading) {
                                    Text(product.title)
                                        .fontWeight(.bold)
                                    Text("$\(product.price).00")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteItems)
                }

                HStack {
                    Text("Total:")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()

                    Text("$\(viewModel.fav.reduce(0) { $0 + $1.price }).00")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 16 / 255, green: 120 / 255, blue: 12 / 255, opacity: 1))
                }
                .padding()
                
                Button("Add to Cart & Delete") {
                    viewModel.addToCart(products: viewModel.recentlyViewed)
                    viewModel.recentlyViewed.removeAll()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
                .font(.title)
            }
            .navigationTitle("Recently Viewed")
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        viewModel.cart.remove(atOffsets: offsets)
    }
}


struct RecentlyViewedViewPreviews: PreviewProvider {
    static var previews: some View {
        RecentlyViewedView(viewModel: ProductViewModel())
    }
}

