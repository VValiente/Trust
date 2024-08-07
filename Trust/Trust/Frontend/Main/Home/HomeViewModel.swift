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
    enum RequestState: Equatable {
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

                    let popularTokens = topCryptos.map { cryptoDTO in
                        DataParser.parse(cryptoDTO: cryptoDTO, currencySymbol: "$")
                    }
                    popularTokensRequestState = .success(popularTokens)

                case let .failure(error):
                    print("failure: \(error)")
                    popularTokensRequestState = .failure
            }
        }
    }
}
