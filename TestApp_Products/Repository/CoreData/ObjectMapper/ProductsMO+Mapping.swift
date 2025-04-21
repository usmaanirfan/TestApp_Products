//
//  ProductsMO+Mapping.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation
import CoreData

extension ProductsMO {
    func toDomain() -> Products {
        let products = (products ?? NSSet())
            .toArray(of: ProductMO.self)
            .compactMap { $0.toDomain() }
        return .init(products: products, total: Int(total), skip: Int(skip), limit: Int(limit))
    }
}

extension Products {
    func toEntity(in context: NSManagedObjectContext) -> ProductsMO {
        let entity: ProductsMO = .init(context: context)
        entity.total = Int64(total)
        entity.skip = Int64(total)
        entity.limit = Int64(limit)
        entity.products = NSSet(array: products.map { $0.toEntity(in: context)})
        return entity
    }
}

