//
//  ProductsListViewModel.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation
import SwiftUI

protocol DetailRoutable {
    func productDetailView(id: Int) -> AnyView
}

@MainActor
@Observable class ProductsListViewModel {
    private(set) var productItems : [ProductListItem] = []
    private(set) var isFetching : Bool = false
    private let productUseCases : ProductsUseCases
    private  var  detailRoutable: any DetailRoutable
    private(set) var loadingError: Error? = nil

    init(productUseCases: ProductsUseCases, detailRoutable: DetailRoutable) {
        self.productUseCases = productUseCases
        self.detailRoutable = detailRoutable
    }
    
    func loadProducts() async {
        loadingError = nil
        isFetching = true
        do {
            let products = try await productUseCases.loadProducts()
            productItems = products.products.map { ProductListItem(id: $0.id, title: $0.title, description: $0.description, thumbnail: $0.thumbnail)
            }
        }
        catch {
            loadingError = error
        }
        isFetching = false
    }
    
    func productDetailView(id: Int) -> some View {
        detailRoutable.productDetailView(id:id)
    }
}
