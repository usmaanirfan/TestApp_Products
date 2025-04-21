//
//  TestApp__ProductsApp.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-18.
//

import SwiftUI

@main
struct TestApp__ProductsApp: App {
    let persistenceController = ProductDepenedencyManager()

    var body: some Scene {
        WindowGroup {
            ProductListView(productsListVM: persistenceController.makeProductListViewModel())
        }
    }
}
