//
//  ImageMO+Mapping.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation
import CoreData
extension ImageMO {
    func toDomain() -> String? {
        return image
    }
}

extension String {
    func toEntity(in context: NSManagedObjectContext) -> ImageMO {
        let entity: ImageMO = .init(context: context)
        entity.image = self
        return entity
    }
}
