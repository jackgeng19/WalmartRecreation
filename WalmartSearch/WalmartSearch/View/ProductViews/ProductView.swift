//
//  ProductView.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import SwiftUI

struct ProductView: View {
    let product: Product

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 125)
                .cornerRadius(5)
                .padding(.bottom, 4)

                // Product title and price
                VStack (alignment: .leading) {
                    Text("Now $\(String(product.price)).00")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.bottom, 5)
                        .padding(.top, -5)
                    
                    Text(product.title)
                        .font(.title3)
                        .padding(.vertical, 7)
                    
                    HStack {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        Text("\(product.rating, specifier: "%.1f")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 7)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            
            HStack {
                Spacer(minLength: 220)
                VStack {
                    Text("Save with W+")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.leading, -99)
                        .padding(.bottom, 7)
                    HStack {
                        Text("Free shipping, arrives")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("in 2 days")
                            .font(.caption)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.primary)
                            .padding(.leading, -5)
                    }
                    .padding(.leading, -18)
                    .padding(.bottom, 7)
                    
                    Button(action: {}) {
                        Text("Add to cart")
                            .fontWeight(.bold)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(38)
                    .padding(.horizontal, 5)
                    .padding(.leading, -11)
                    .padding(.trailing, 7)
                }

            }
        }

        Divider()
    }
}

#Preview {
    ProductView(product: Product(
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
               )
    )
}
