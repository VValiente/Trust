//
//  MockTopCryptoState.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

@testable import Trust
import XCTest

class MockTopCryptoState: TopCryptoStateDelegate {
    var topCryptos: [CryptoDTO] = []

    func update(topCryptos: [CryptoDTO]) {
        self.topCryptos = topCryptos
    }
}
