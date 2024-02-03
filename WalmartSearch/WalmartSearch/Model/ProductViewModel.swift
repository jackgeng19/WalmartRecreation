//
//  ProductViewModel.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import Foundation

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cart: [Product] = []
    @Published var searchTerm: String = ""
    @Published var product: Product = .sample
    var searched: Bool = false

    func fetchAndPrintProducts() async {
        do {
            self.products = try await SearchService.findProducts()
            printProducts() // Testing
        } catch {
            print("Error: \(error)")
        }
    }
    
    func searchProducts() async {
        do {
            self.products = try await SearchService.searchProducts(query: searchTerm)
            printProducts() 
        } catch {
            print("Error: \(error)")
        }
        searched = true
    }
    
    func printCart() {
        print("ITEMS IN CART:")
        for item in cart {
            print(item)
        }
    }
    
    func removeFromCart(at index: IndexSet) {
        cart.remove(atOffsets: index)
    }
    
    private func printProducts() {
        for product in products {
//            print("Product ID: \(product.id), Title: \(product.title)")
            print(product)
        }
    }
}
