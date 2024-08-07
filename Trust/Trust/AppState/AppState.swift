//
//  AppState.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

@Observable
class AppState {
    // MARK: - Shared Instance

    static var shared = AppState()

    // MARK: - Public Properties accessible via State Delegates

    var topCryptos: [CryptoDTO]

    // MARK: - Init

    init(
        topCryptos: [CryptoDTO] = []
    ) {
        self.topCryptos = topCryptos
    }
}
