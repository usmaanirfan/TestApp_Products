//
//  ProductDetailView.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

@MainActor
@Observable class ProductDetailViewModel {
    private(set) var productDetailItem : ProductDetailItem?
    private(set) var isFetching : Bool = false
    private let productUseCases : ProductsUseCases
    private let productId: Int
    private(set) var loadingError: Error? = nil

    init(productUseCases: ProductsUseCases, productId: Int) {
        self.productUseCases = productUseCases
        self.productId = productId
        
    }
    func loadProductDetail() async {
        isFetching = true
        loadingError = nil
        do {
            let productDetail = try await productUseCases.loadProductsDetail(id: productId)
            productDetailItem = ProductDetailItem(id: productDetail.id, title: productDetail.title, description: productDetail.description, image: productDetail.images.first, rating: productDetail.rating, brand: productDetail.brand)
        }
        catch {
            loadingError = error
        }
        isFetching = false
    }
}
