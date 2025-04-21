//
//  ImageLoaderView.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import SwiftUI
struct ImageLoaderView: View {
    var urlString: String = ProductConstants.randomImage
    var body: some View {
        Rectangle()
            .opacity(0.0001)
            .overlay {
                CachedAsyncImage(url: URL(string: urlString))
                
            }
            .clipped()
        
    }
    
    
}

#Preview {
    ImageLoaderView()
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
}
