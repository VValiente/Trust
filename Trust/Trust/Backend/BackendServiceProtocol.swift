//
//  BackendServiceProtocol.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

protocol BackendServiceProtocol {
    /// Fetches the coins by market cap in descending order.
    /// - Parameters:
    ///   - currency: The target currency of coins and market data. Defaults to `usd`.
    ///   - numberOfCoins: The total number of coins to fetch. Defaults to `5`.
    ///   - priceChangePercentage: The price change percentage timeframe.
    /// - Returns: If successful, returns an array of the top coins by market cap. Otherwise, returns a `NetworkError`.
    func fetchTopCryptocurrencies(currency: String, numberOfCoins: Int) async -> Result<[CryptoDTO], NetworkError>
}
