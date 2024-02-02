//
//  Product.swift
//  WalmartSearch
//
//  Created by Qicheng Geng on 2/1/24.
//
import Foundation

struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
