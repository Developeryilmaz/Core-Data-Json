//
//  ProductModel.swift
//  CoreJSON
//
//  Created by YILMAZ ER on 25.05.2023.
//

import Foundation

struct Result: Codable, Hashable {
    let products: [ProductModel]
    let total, skip, limit: Int
}

// MARK: - ProductElement
struct ProductModel: Codable, Hashable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
