//
//  ProductDetailView.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import SwiftUI

struct ProductDetailView: View {
    @State var productDetailViewModel : ProductDetailViewModel
    
    init(productDetailViewModel: ProductDetailViewModel) {
        _productDetailViewModel = State(wrappedValue: productDetailViewModel)
    }
    var shadowColor : Color = .tBlack.opacity(0.8)
    
    ///Overlay on image having title an drating
    private func imageOverlay(productDetailItem : ProductDetailItem) -> some View {
        HStack(spacing: 8) {
            Text(productDetailItem.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            HStack {
                Image(systemName: "star.fill")
                let formattedRating = String(format: "%.1f", productDetailItem.rating)
                Text("\(formattedRating)")
            }
            .font(.body)
            
        }
        .foregroundStyle(.tWhite)
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if productDetailViewModel.isFetching {
                ProgressView("Loading products...")
                    .controlSize(.large)
            }
            ///Show errro if error occurs in loading
            else if let error = productDetailViewModel.loadingError {
                ErrorView(errorMessage: error.localizedDescription) {
                    Task {
                        await productDetailViewModel.loadProductDetail()
                    }
                }
            }
            ///Show product detail
            if let productDetailItem = productDetailViewModel.productDetailItem {
                if let image = productDetailItem.image {
                    ImageLoaderView(urlString: image)
                        .overlay (
                            imageOverlay(productDetailItem: productDetailItem)
                            , alignment: .bottomLeading
                        )
                        .frame(height: 300)
                }
                Text(productDetailItem.description ?? "")
                    .font(.body)
                    .foregroundStyle(.tDarkGray)
                    .padding(16)
            }
            
        }
        .onAppear {
            Task {
                await productDetailViewModel.loadProductDetail()
            }
        }
    }
}
