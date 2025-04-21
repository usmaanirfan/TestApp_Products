//
//  ProductsDBRepository.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import CoreData

actor ProductsDBRepository : ProductsCachable {
    private let coreDataStorage: CoreDataStack

    init(coreDataStorage: CoreDataStack) {
        self.coreDataStorage = coreDataStorage
    }
    
    /// Load Products from core data using.
    /// - Returns: Products
    func loadProducts() async throws -> Products {
        let context = coreDataStorage.container.viewContext
        let products = try await context.perform {
            let request: NSFetchRequest = ProductsMO.fetchRequest()
            let result = try context.fetch(request).map { $0.toDomain() }
            return result
        }
        guard let products = products.first else {
            throw CoreDataStorageError.notFound
        }
        return products
    }
    
    /// Load ProductDetail from core data .
    /// - Returns: ProductDetail
    func loadProductDetail(id: Int) async throws -> ProductDetail {
        let context = coreDataStorage.container.viewContext
        let productsDetails = try await context.perform {
            let request: NSFetchRequest = ProductDetailMO.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            request.fetchLimit = 1
            let result = try context.fetch(request).map { $0.toDomain() }
            return result
        }
        guard let productsDetail = productsDetails.first else {
            throw CoreDataStorageError.notFound
        }
        return productsDetail
    }
    
    /// store Products into core data .
    func store(products: Products) async throws {
        let context = coreDataStorage.container.viewContext
        try await context.perform {
            _ = products.toEntity(in: context)
            try context.save()
        }
    }
    
    /// store ProductDetail into core data .
    func store(productDetail: ProductDetail) async throws {
        let context = coreDataStorage.container.viewContext
        try await context.perform {
            _ = productDetail.toEntity(in: context)
            try context.save()
        }
    }
    
}
