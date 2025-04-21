//
//  ProductDetail.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

// MARK: - ProductDetail
struct ProductDetail: Codable {
    let id: Int
    let title : String
    let description, category: String?
    let price, rating: Double
    let brand, sku: String?
    let reviews: [Review]
    let images: [String]
    let thumbnail: String?
}

// MARK: - Review
struct Review: Codable {
    let rating: Double
    let comment: String
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let width, height, depth: Double
}
