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
    @Published var fav: [Product] = []
    @Published var recentlyViewed: [Product] = []
    @Published var searchTerm: String = ""
    @Published var product: Product = .sample
    var searched: Bool = false
    
    init() {
        loadFavorites()
        loadRecentlyViewedProducts()
    }

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
    
    func addToFavorites(_ product: Product) {
        if !fav.contains(where: { $0.id == product.id }) {
            fav.append(product)
            saveFavorites()
        }
    }
    
    func removeFromFavorites(_ product: Product) {
        fav.removeAll { $0.id == product.id }
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(fav) {
            UserDefaults.standard.set(encoded, forKey: "Favorites")
        }
    }
    
    private func loadFavorites() {
        // Store small amounts of data persustently as app launches
        if let savedFavorites = UserDefaults.standard.data(forKey: "Favorites"),
           let decodedFavorites = try? JSONDecoder().decode([Product].self, from: savedFavorites) {
            fav = decodedFavorites
        }
    }
    
    func addRecentlyViewedProduct(_ product: Product) {
        // Avoid duplicating the product in the list (that's why Product has to conform Equatable)
        if !recentlyViewed.contains(where: { $0.id == product.id }) {
            recentlyViewed.insert(product, at: 0) // Add at the beginning
            if recentlyViewed.count > 10 { // Limit the number of stored products
                recentlyViewed.removeLast()
            }
            saveRecentlyViewedProducts()
        }
    }

    private func saveRecentlyViewedProducts() {
        if let encoded = try? JSONEncoder().encode(recentlyViewed) {
            UserDefaults.standard.set(encoded, forKey: "RecentlyViewedProducts")
        }
    }

    private func loadRecentlyViewedProducts() {
        if let savedProducts = UserDefaults.standard.data(forKey: "RecentlyViewedProducts"),
           let decodedProducts = try? JSONDecoder().decode([Product].self, from: savedProducts) {
            recentlyViewed = decodedProducts
        }
    }
}
