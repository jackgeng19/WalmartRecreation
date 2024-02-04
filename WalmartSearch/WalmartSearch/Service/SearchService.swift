//
//  Search Service.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//

import Foundation

struct ProductsResponse: Codable {
    let products: [Product]
}

struct SearchService {
    private static let session = URLSession.shared

    public static func findProducts() async throws -> [Product] {
    
        let urlString = "https://dummyjson.com/products"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(ProductsResponse.self, from: data)
        return response.products
    }
    
    public static func searchProducts(query: String) async throws -> [Product] {
        let urlString = "https://dummyjson.com/products/search?q=\(query)"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(ProductsResponse.self, from: data)
        return response.products
    }
}

extension SearchService {
    struct SortOption {
        let title: String
        let value: String
    }
    
    public static let sortOptions: [SortOption] = [
        .init(title: "Best Match", value: "best_match"),
        .init(title: "Rating Increasing", value: "rating_in"),
        .init(title: "Rating decreasing", value: "rating_de"),
        .init(title: "Price Increasing", value: "price_in"),
        .init(title: "Price Decreasing", value: "price_de")
    ]
}
