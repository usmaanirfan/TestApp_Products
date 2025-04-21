//
//  ProductsuseCasesTests.swift
//  TestApp_ProductsTests
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import XCTest
@testable import TestApp_Products

@MainActor
final class ProductsUseCasesTests: XCTestCase {
    var sut: ProductsUseCases!
    var mockWebRepository: MockProductsFetchableRepository!
    var mockDBRepository: MockProductsStorableRepository!

    override func setUp() {
        super.setUp()
        mockWebRepository = MockProductsFetchableRepository()
        mockDBRepository = MockProductsStorableRepository()
        sut = ProductsUseCases(webRepository: mockWebRepository, dbRepository: mockDBRepository)
    }

    override func tearDown() {
        sut = nil
        mockWebRepository = nil
        mockDBRepository = nil
        super.tearDown()
    }

    func testLoadProducts_SuccessFromWebRepository() async throws {
        // Arrange
        let productsArray = [Product(id: 1, title: "Test Product", description: "Test Description", price: 100.0, thumbnail: "test.png")]
        let expectedProducts = Products(products: productsArray, total: 1, skip: 1, limit: 1)
        mockWebRepository.loadProductsResult = .success(expectedProducts)

        // Act
        let products = try await sut.loadProducts()

        // Assert
        XCTAssertEqual(products.products.count, 1)
        XCTAssertEqual(products.products.first?.title, "Test Product")
        XCTAssertTrue(mockWebRepository.loadProductsCalled)
        XCTAssertTrue(mockDBRepository.storeProductsCalled)
    }

    func testLoadProducts_FallbackToDBOnWebFailure() async throws {
        // Arrange
        let productsArray = [Product(id: 1, title: "DB Product", description: "Test Description", price: 100.0, thumbnail: "test.png")]
        let expectedProducts = Products(products: productsArray, total: 1, skip: 1, limit: 1)
        mockWebRepository.loadProductsResult = .success(expectedProducts)
        mockWebRepository.loadProductsResult = .failure(NSError(domain: "TestError", code: 1, userInfo: nil))
        mockDBRepository.loadProductsResult = .success(expectedProducts)

        // Act
        let products = try await sut.loadProducts()

        // Assert
        XCTAssertEqual(products.products.count, 1)
        XCTAssertEqual(products.products.first?.title, "DB Product")
        XCTAssertTrue(mockWebRepository.loadProductsCalled)
        XCTAssertTrue(mockDBRepository.loadProductsCalled)
    }

    func testLoadProductsDetail_SuccessFromWebRepository() async throws {
        // Arrange
        let expectedProductDetail = ProductDetail(id: 1, title: "Test Detail", description: "Detail Description", category: nil, price: 100.0, rating: 4.0, brand: "brand", sku: nil, reviews: [], images: [], thumbnail: nil)
        mockWebRepository.loadProductDetailResult = .success(expectedProductDetail)

        // Act
        let productDetail = try await sut.loadProductsDetail(id: 1)

        // Assert
        XCTAssertEqual(productDetail.title, "Test Detail")
        XCTAssertTrue(mockWebRepository.loadProductDetailCalled)
        XCTAssertTrue(mockDBRepository.storeProductDetailCalled)
    }

    func testLoadProductsDetail_FallbackToDBOnWebFailure() async throws {
        // Arrange
        let expectedProductDetail = ProductDetail(id: 1, title: "DB Detail", description: "Detail Description", category: nil, price: 100.0, rating: 4.0, brand: "brand", sku: nil, reviews: [], images: [], thumbnail: nil)
        mockWebRepository.loadProductDetailResult = .success(expectedProductDetail)
        mockWebRepository.loadProductDetailResult = .failure(NSError(domain: "TestError", code: 1, userInfo: nil))
        mockDBRepository.loadProductDetailResult = .success(expectedProductDetail)

        // Act
        let productDetail = try await sut.loadProductsDetail(id: 2)

        // Assert
        XCTAssertEqual(productDetail.title, "DB Detail")
        XCTAssertTrue(mockWebRepository.loadProductDetailCalled)
        XCTAssertTrue(mockDBRepository.loadProductDetailCalled)
    }
}
