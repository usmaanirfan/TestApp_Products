//
//  ProductsStorableRepository.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

/// Protocol to store product and detail
protocol ProductsStorableRepository {
    func store(products: Products) async throws
    func store(productDetail: ProductDetail) async throws
}
