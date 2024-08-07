//
//  CryptoDTO+TestData.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation
@testable import Trust

extension CryptoDTO {
    enum TestData {
        static let bitcoin = CryptoDTO(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: URL(string: "https://example.com/bitcoin.png")!, currentPrice: 50000.0, priceChangePercentage24h: 2.5)
        static let ethereum = CryptoDTO(id: "ethereum", symbol: "eth", name: "Ethereum", image: URL(string: "https://example.com/ethereum.png")!, currentPrice: 4000.0, priceChangePercentage24h: 1.2)
    }
}
