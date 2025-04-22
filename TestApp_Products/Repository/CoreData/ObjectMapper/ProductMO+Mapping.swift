//
//  ProductMO.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation
import CoreData

extension ProductMO {
    func toDomain() -> Product {
        return .init(id: Int(id), title: title ?? "", description: productDescription, price: price,  thumbnail: thumbnail)
    }
}

extension Product {
    func toEntity(in context: NSManagedObjectContext) -> ProductMO {
        let entity: ProductMO
        let request: NSFetchRequest = ProductMO.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        let results = try? context.fetch(request)
        if results?.count == 0 {
             entity = .init(context: context)
        } else {
            entity = results?.first ?? .init(context: context)
        }
        entity.id = Int64(id)
        entity.title = title
        entity.productDescription = description
        entity.price = price
        entity.thumbnail = thumbnail
        return entity
    }
}
