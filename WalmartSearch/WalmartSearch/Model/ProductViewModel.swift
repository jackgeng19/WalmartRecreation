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
    @Published var sortOption: String = SearchService.sortOptions[0].value {
        didSet {
            Task {
                await sortProducts()

            }
        }
    }

    var searched: Bool = false
    
    @Published var comments: [Comment] = [
        Comment(user: User(profileImage: "🐙", userName: "Ms. Squid"), timestamp: Date(), commentString: "Love this product!"),
        Comment(user: User(profileImage: "🐌", userName: "Mr. Snail"), timestamp: Date().addingTimeInterval(-86400 * 2), commentString: "Delivery speed is slower than mine"),
        // Add more comments as needed
    ]
    
    init() {
        loadRecentlyViewedProducts()
    }

    func printFav() {
        print("ITEMS IN FAV:")
        for item in fav {
            print(item)
        }
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
        
            fav.append(product)
        
    }
    
    func removeFromFavorites(product: Product) {
        fav.removeAll { $0.id == product.id }
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
    
    func sortProducts() async {
        switch sortOption {
        case "best_match":
            if !searchTerm.isEmpty && searched {
                await searchProducts()
            } else {
                await fetchAndPrintProducts()
            }
        case "rating_in":
            products.sort { $0.rating < $1.rating }
        case "rating_de":
            products.sort { $0.rating > $1.rating }
        case "price_in":
            products.sort { $0.price < $1.price }
        case "price_de":
            products.sort { $0.price > $1.price }
        default:
            break
        }
    }
    
}
