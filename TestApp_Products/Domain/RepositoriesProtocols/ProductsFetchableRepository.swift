//
//  ProductsRepositoryProtocol.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation


/// Protocol to load product and detail
protocol ProductsFetchableRepository : Sendable  {
    func loadProducts() async throws -> Products
    func loadProductDetail(id : Int) async throws -> ProductDetail
}
