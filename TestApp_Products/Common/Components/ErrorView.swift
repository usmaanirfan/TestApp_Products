//
//  ErrorView.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage : String
    let retryAction: () -> Void
    var body: some View {
        VStack {
            Text(errorMessage)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    ErrorView(errorMessage: "Failed to load products..", retryAction: {
        // Retry
    })
}
