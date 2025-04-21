//
//  ProductsWebRepository.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

actor ProductsWebRepository : ProductsFetchableRepository, WebRepository {
    let session : URLSession
    let baseURL: String
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    /// loadProducts from web using rest api
    /// - Returns: Products
    func loadProducts() async throws -> Products {
        return try await call(endpoint: API.allProducts)
    }
    
    /// loadProductDetail from web using rest api
    /// - Returns: ProductDetail
    func loadProductDetail(id : Int) async throws -> ProductDetail {
        return try await call(endpoint: API.productDetail(id: id))
    }
    
}

extension ProductsWebRepository {
    enum API {
        case allProducts
        case productDetail(id: Int)
    }
}

extension ProductsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .allProducts:
            return "/products"
        case .productDetail(id: let id):
            return "/products/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .allProducts:
            return .get
        case .productDetail(id: _):
            return .get
        }
    }
}
