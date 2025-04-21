//
//  MoviesUseCasesProtocols.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

/// Protocol to interact with  ProductsUseCases.
protocol ProductsFetchableUseCases {
    func loadProducts() async throws -> Products
}
