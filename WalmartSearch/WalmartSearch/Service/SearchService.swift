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

