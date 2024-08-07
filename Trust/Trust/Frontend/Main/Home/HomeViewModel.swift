//
//  HomeViewModel.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

@Observable
final class HomeViewModel {
    // MARK: - Public Properties

    var popularTokensRequestState: RequestState = .idle
    enum RequestState {
        case idle
        case loading
        case success([PopularTokenViewData])
        case failure
    }

    // MARK: - Private Properties

    private let backendService: BackendServiceProtocol
    private let topCrytoState: TopCryptoStateDelegate

    // MARK: - Init

    init(
        backendService: BackendServiceProtocol = BackendService(),
        topCrytoState: TopCryptoStateDelegate = AppState.shared
    ) {
        self.backendService = backendService
        self.topCrytoState = topCrytoState
    }

    // MARK: - Public APIs

    func fetchPopularTokens() {
        popularTokensRequestState = .loading

        Task {
            // TODO: Implement a more sophisticated currency model to avoid hardcoding.
            let result = await backendService.fetchTopCryptocurrencies(currency: "usd", numberOfCoins: 5)
            switch result {
                case let .success(topCryptos):
                    // Update the App State with the latest downloaded crypto.
                    topCrytoState.update(topCryptos: topCryptos)

                    let popularTokens = topCryptos.map { crypto in
                        PopularTokenViewData(
                            id: crypto.id,
                            imageURL: crypto.image,
                            title: crypto.symbol.uppercased(),
                            subtitle: crypto.name,
                            price: displayCurrentPrice(from: "$", currentPrice: crypto.currentPrice),
                            priceChange: displayPriceChange(from: crypto.priceChangePercentage24h)
                        )
                    }
                    popularTokensRequestState = .success(popularTokens)

                case let .failure(error):
                    print("failure: \(error)")
                    popularTokensRequestState = .failure
            }
        }
    }

    // MARK: - Private APIs

    private func displayCurrentPrice(from currencySymbol: String, currentPrice: Double?) -> String {
        guard let currentPrice else {
            return ""
        }

        return PriceFormatter.shared.formatPrice(currentPrice, currencySymbol: currencySymbol)
    }

    private func displayPriceChange(from priceChangePercentage: Double?) -> Double {
        guard let priceChangePercentage else {
            return 0.0
        }

        return (priceChangePercentage * 100).rounded() / 100
    }
}
