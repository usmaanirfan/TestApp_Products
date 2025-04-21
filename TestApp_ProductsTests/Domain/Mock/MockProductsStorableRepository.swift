//
//  MockProductsStorableRepository.swift
//  TestApp_ProductsTests
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

@testable import TestApp_Products
import Foundation

@MainActor
final class  MockProductsStorableRepository: ProductsCachable {
    var storeProductsCalled = false
    func store(products: Products) async throws {
        storeProductsCalled = true
    }
    
    var loadProductsCalled = false
    var loadProductsResult: Result<Products, Error> = .failure(NSError(domain: "TestError", code: 1, userInfo: nil))
    
    func loadProducts() async throws -> Products {
        loadProductsCalled = true
        switch loadProductsResult {
        case .success(let products):
            return products
        case .failure(let error):
            throw error
        }
    }
    
    var storeProductDetailCalled = false
    func store(productDetail: ProductDetail) async throws {
        storeProductDetailCalled = true
    }
    
    var loadProductDetailCalled = false
    var loadProductDetailResult: Result<ProductDetail, Error> = .failure(NSError(domain: "TestError", code: 1, userInfo: nil))
    
    func loadProductDetail(id: Int) async throws -> ProductDetail {
        loadProductDetailCalled = true
        switch loadProductDetailResult {
        case .success(let productDetail):
            return productDetail
        case .failure(let error):
            throw error
        }
    }
}
