//
//  TopCryptoStateDelegate.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

// MARK: - TopCryptoStateDelegate

protocol TopCryptoStateDelegate {
    var topCryptos: [CryptoDTO] { get }

    func update(topCryptos: [CryptoDTO])
}

// MARK: - AppState + TopCryptoStateDelegate

extension AppState: TopCryptoStateDelegate {
    func update(topCryptos: [CryptoDTO]) {
        self.topCryptos = topCryptos
    }
}
