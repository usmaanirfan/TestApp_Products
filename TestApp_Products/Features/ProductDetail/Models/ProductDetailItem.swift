//
//  ProductDetailItem.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation
///UI related model
struct ProductDetailItem : Identifiable {
    let id: Int
    let title: String
    let description: String?
    let image: String?
    let rating: Double
    let brand: String?
}
