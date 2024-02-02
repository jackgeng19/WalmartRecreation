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
    @Published var searchTerm: String = ""


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
    }
    
    private func printProducts() {
        for product in products {
//            print("Product ID: \(product.id), Title: \(product.title)")
            print(product)
        }
    }
}
