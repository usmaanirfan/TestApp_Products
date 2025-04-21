//
//  ReviewMO+Mapping.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation
import CoreData

extension ReviewMO {
    func toDomain() -> Review {
        return .init(rating: rating, comment: comment ?? "")
    }
}

extension Review {
    func toEntity(in context: NSManagedObjectContext) -> ReviewMO {
        let entity: ReviewMO = .init(context: context)
        entity.rating = rating
        entity.comment = comment
        return entity
    }
}
