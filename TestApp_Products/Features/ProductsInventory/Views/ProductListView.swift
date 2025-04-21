//
//  ProductListView.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import SwiftUI

struct ProductListView: View {
    @State var productsListVM : ProductsListViewModel
    init(productsListVM: ProductsListViewModel) {
        _productsListVM = State(wrappedValue: productsListVM)
    }
    
    private var productListView : some View {
        ///Show list of products
        List {
            ForEach(productsListVM.productItems) { productItem in
                NavigationLink {
                    productsListVM.productDetailView(id: productItem.id)
                } label: {
                    ProductItemcell(imagePath: productItem.thumbnail, title: productItem.title, description: productItem.description)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Products")
    }
    
    var body: some View {
        NavigationStack {
            if productsListVM.isFetching {
                ProgressView("Loading products...")
                    .controlSize(.large)
            }
            else if let error = productsListVM.loadingError {
                ErrorView(errorMessage: error.localizedDescription) {
                    Task {
                        await productsListVM.loadProducts()
                    }
                }
            }
            else {
                productListView
            }
        }
        .task {
            await productsListVM.loadProducts()
        }
    }
    
}
