//
//  PopularTokenDetailView.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

struct PopularTokenDetailView: View {
    // MARK: - Public Properties

    var tokenID: String

    // MARK: - Private Properties

    @State private var viewModel = PopularTokenDetailViewModel()

    // MARK: - Body

    var body: some View {
        VStack {
            Text(verbatim: "id: \(tokenID)")

            if let crypto = viewModel.crypto {
                Text(verbatim: "name: \(crypto.name)")
                Text(verbatim: "symbol: \(crypto.symbol)")
                Text(verbatim: "marketCap: \(String(describing: crypto.marketCap))")
                Text(verbatim: "maxSupply: \(String(describing: crypto.maxSupply))")
            }
        }
        .task {
            viewModel.loadCrypto(with: tokenID)
        }
    }
}

#Preview {
    PopularTokenDetailView(tokenID: "1")
}
