//
//  DepenedencyManager.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

@MainActor
class ProductDepenedencyManager {
    /// Shared CoreDataStack
    static let persistentStore = CoreDataStack()

    ///Create ProductsListViewModel with it dependencies
    func makeProductListViewModel() -> ProductsListViewModel {
        return ProductsListViewModel(productUseCases: self.configuredProductsUseCases(), detailRoutable: ProductsListViewRouter())
    }
    
    ///Create ProductDetailViewModel with it dependencies
    func makeProductDetailViewModel(productId: Int) -> ProductDetailViewModel {
        return ProductDetailViewModel(productUseCases: self.configuredProductsUseCases(), productId: productId)
    }
    
    private  func configuredWebRepositories(session: URLSession) -> ProductsWebRepository {
        return ProductsWebRepository(session: session, baseURL: "https://dummyjson.com")
    }
    
    private  func configuredDBRepositories() -> ProductsDBRepository {
        return ProductsDBRepository(coreDataStorage: ProductDepenedencyManager.persistentStore)
    }
    
    private  func configuredProductsUseCases() -> ProductsUseCases {
        let webRepo = configuredWebRepositories(session: configuredURLSession())
        return ProductsUseCases(webRepository: webRepo, dbRepository: configuredDBRepositories())
    }
    
    private  func configuredURLSession() ->  URLSession {
        let uRLSession = URLSession(configuration: .default)
        uRLSession.configuration.timeoutIntervalForRequest = 60
        uRLSession.configuration.timeoutIntervalForResource = 120
        uRLSession.configuration.waitsForConnectivity = true
        uRLSession.configuration.httpMaximumConnectionsPerHost = 5
        uRLSession.configuration.requestCachePolicy = .returnCacheDataElseLoad
        uRLSession.configuration.urlCache = .shared
        return uRLSession
    }
}
