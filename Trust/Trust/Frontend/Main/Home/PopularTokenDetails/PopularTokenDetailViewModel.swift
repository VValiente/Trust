//
//  PopularTokenDetailViewModel.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

@Observable
final class PopularTokenDetailViewModel {
    // MARK: - Public Properties

    var crypto: CryptoDTO?

    // MARK: - Private Properties

    private let topCrytoState: TopCryptoStateDelegate

    // MARK: - Init

    init(topCrytoState: TopCryptoStateDelegate = AppState.shared) {
        self.topCrytoState = topCrytoState
    }

    // MARK: - Public APIs

    func loadCrypto(with id: String) {
        guard let crypto = topCrytoState.topCryptos.first(where: { $0.id == id }) else {
            return
        }

        self.crypto = crypto
    }
}
