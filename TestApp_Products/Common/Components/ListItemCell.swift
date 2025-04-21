//
//  ListItemCell.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import SwiftUI
struct ProductItemcell: View {
    var imagePath : String?
    var title: String
    var description: String?
    var body: some View {
        HStack {
            if let imagePath {
                ImageLoaderView(urlString: imagePath)
                    .frame(width: ProductConstants.ListImageHeightWidth, height: ProductConstants.ListImageHeightWidth)
                    .cornerRadius(ProductConstants.ListImageCornerRadius)
            }
            VStack(alignment: .leading) {
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundStyle(.tBlack)
                Text(description ?? "")
                    .font(.caption)
                    .foregroundStyle(.tGray)
                    .lineLimit(2)
            }
        }
        .padding(.trailing,8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HStack {
        ProductItemcell(imagePath: ProductConstants.randomImage, title: "Title", description: "Description")
    }
}

