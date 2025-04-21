//
//  MoviesUseCases.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

typealias ProductsCachable = ProductsFetchableRepository &  ProductsStorableRepository

actor ProductsUseCases: ProductsFetchableUseCases {
    
    nonisolated private let webRepository: ProductsFetchableRepository
    private let dbRepository: ProductsCachable

    init(webRepository: ProductsFetchableRepository, dbRepository: ProductsCachable) {
        self.webRepository = webRepository
        self.dbRepository = dbRepository
    }
    
    /// Load products from the web repo using rest API and store them in the database repo. It returns cache data from database if api fails.
    /// - Returns: Products
    func loadProducts() async throws -> Products {
        do {
            let products = try await webRepository.loadProducts()
            try await dbRepository.store(products: products)
            return products
        } catch {
            return try await dbRepository.loadProducts()
        }

    }
    
    /// Load  products detail from rest API from web repo and store them into database. It returns cache data from database if api fails.
    /// - Parameter id: Int
    /// - Returns: ProductDetail
    func loadProductsDetail(id : Int) async throws -> ProductDetail {
        do {
            let productDetail = try await webRepository.loadProductDetail(id: id)
            try await dbRepository.store(productDetail: productDetail)
            return productDetail
        }
        catch {
            return try await dbRepository.loadProductDetail(id: id)
        }
    }
}
