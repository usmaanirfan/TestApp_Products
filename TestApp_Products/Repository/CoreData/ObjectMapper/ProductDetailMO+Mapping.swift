//
//  ProductDetailMO+Mapping.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import CoreData

extension ProductDetailMO {
    func toDomain() -> ProductDetail {
        
        let reviews = (reviews ?? NSSet())
            .toArray(of: ReviewMO.self)
            .compactMap { $0.toDomain() }
        
        let images = (images ?? NSSet())
            .toArray(of: ImageMO.self)
            .compactMap { $0.toDomain() }
        
        return .init(id: Int(id), title: title ?? "", description: productDescription, category: category, price: price, rating: rating, brand: brand, sku: sku, reviews: reviews, images: images, thumbnail: thumbnail)
    }
    
}

extension ProductDetail {
    func toEntity(in context: NSManagedObjectContext) -> ProductDetailMO {
        let entity: ProductDetailMO = .init(context: context)
        entity.id = Int64(id)
        entity.title = title
        entity.productDescription = description
        entity.price = price
        entity.rating = rating
        entity.brand = brand
        entity.category = category
        entity.images = NSSet(array: images.map { $0.toEntity(in: context)})
        entity.reviews = NSSet(array: reviews.map { $0.toEntity(in: context)})
        return entity
    }
}
