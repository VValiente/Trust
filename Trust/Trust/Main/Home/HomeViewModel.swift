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
        case success([CryptoDTO])
        case failure
    }

    // MARK: - Private Properties

    private let backendService: BackendServiceProtocol

    // MARK: - Init

    init(backendService: BackendServiceProtocol = BackendService()) {
        self.backendService = backendService
    }

    // MARK: - Public APIs

    func fetchPopularTokens() {
        popularTokensRequestState = .loading

        Task {
            let result = await backendService.fetchTopCryptocurrencies(currency: "usd", numberOfCoins: 5)
            switch result {
                case let .success(topCryptos):
                    popularTokensRequestState = .success(topCryptos)

                case let .failure(error):
                    print("failure: \(error)")
                    popularTokensRequestState = .failure
            }
        }
    }
}
