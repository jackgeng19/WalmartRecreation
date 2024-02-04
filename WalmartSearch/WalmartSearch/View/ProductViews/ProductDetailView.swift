//
//  ProductDetailView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/2/24.
//

import SwiftUI
import UIKit

struct ProductDetailView: View {
    @ObservedObject var vm: ProductViewModel
    let product: Product
    @State private var showingShareSheet = false

    var body: some View {
        ScrollView {
            ZStack {
                Button(action: {
                    if vm.fav.contains(where: { $0.id == product.id }) {
                        vm.removeFromFavorites(product: product)
                    } else {
                        vm.addToFavorites(product: product)
                    }
                }) {
                    Image(systemName: vm.fav.contains(where: { $0.id == product.id }) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .opacity(0.8)
                        .padding(.leading, 300)
                        .padding(.bottom, 200)
                        .background(Color.white.opacity(0.6))
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                .buttonStyle(BorderlessButtonStyle())
                
                Button(action: {
                                        showingShareSheet = true
                                    }) {
                                        Image(systemName: "square.and.arrow.up")
                                            .foregroundColor(.blue)
                                            .opacity(0.8)
                                            .padding()
                                            .background(Color.white.opacity(0.6))
                                            .font(.title2)
                                    }
                                    .padding(.leading, 300)
                                    .padding(.bottom, 100)
                                    .sheet(isPresented: $showingShareSheet) {
                                        ShareSheet(items: [URL(string: product.thumbnail) ?? ""])
                                    }
                
                VStack(alignment: .leading, spacing: 10) {
                    AsyncImage(url: URL(string: product.thumbnail)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)

                    // Product title
                    Text(product.title)
                        .font(.title)
                        .fontWeight(.bold)

                    // Price and Discount
                    HStack {
                        Text("$\(product.price).00")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 16 / 255, green: 120 / 255, blue: 12 / 255, opacity: 1))
                        if product.discountPercentage > 0 {
                            Text("\(product.discountPercentage, specifier: "%.1f")% off")
                                .foregroundColor(.red)
                                .font(.body)
                                .fontWeight(.bold)
                        }
                    }

                    // Rating
                    HStack {
                        RatingStarView(rating: product.rating)
                        Text("\(product.rating, specifier: "%.1f")/5.0")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                    }

                    // Stock availability
                    Text("Stock: \(product.stock) available")
                        .font(.title2)
                        .foregroundColor(product.stock > 0 ? Color(red: 16 / 255, green: 120 / 255, blue: 12 / 255, opacity: 1) : .red)

                    // Brand and Category
                    VStack(alignment: .leading) {
                        Text("Brand: \(product.brand)")
                        Text("Category: \(product.category)")
                    }
                    .font(.title3)
                    .fontWeight(.medium)
                    
                    Spacer()
                    
                    // Description
                    Text("Description:")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.blue)
                    Text(product.description)
                        .font(.body)

                    // Additional Images
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(product.images, id: \.self) { imageUrl in
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 100, height: 100)
                                .cornerRadius(5)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        vm.cart.append(product)
                        vm.printCart()
                    }) {
                        Text("Add to cart")
                            .fontWeight(.bold)
                            .font(.title)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(38)
                    .padding(.top, 55)
                }
                .padding()
            }
        }
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


#Preview {
    ProductDetailView(vm: ProductViewModel(), product: Product(
        id: 1,
        title: "iPhone 9",
        description: "An apple mobile which is nothing like apple",
        price: 549,
        discountPercentage: 12.96,
        rating: 4.69,
        stock: 94,
        brand: "Apple",
        category: "smartphones",
        thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
        images: [
            "https://cdn.dummyjson.com/product-images/1/1.jpg",
            "https://cdn.dummyjson.com/product-images/1/2.jpg",
            "https://cdn.dummyjson.com/product-images/1/3.jpg",
            "https://cdn.dummyjson.com/product-images/1/4.jpg",
            "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
        ]
    ))
}
