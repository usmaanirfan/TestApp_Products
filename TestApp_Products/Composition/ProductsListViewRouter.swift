//
//  RoutingView.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import SwiftUI

@MainActor
class ProductsListViewRouter : @preconcurrency DetailRoutable {
    ///Router to route into ProductDetailView with its dependencies.
    func productDetailView(id: Int) -> AnyView {
        let productDepenedencyManager = ProductDepenedencyManager()
        return AnyView(ProductDetailView(productDetailViewModel: productDepenedencyManager.makeProductDetailViewModel(productId: id)))
    }
}

