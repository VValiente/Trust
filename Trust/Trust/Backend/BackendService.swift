//
//  BackendService.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

// MARK: - BackendService

class BackendService {
    // MARK: - Private Properties

    private let APIKeyQueryParameter = "x_cg_demo_api_key"
    private let APIKey = "CG-jyAk77FGUDowdrdqHLzTUCRd"

    private let acceptHeaderFieldKey = "accept"
    private let acceptHeaderFieldValue = "application/json"

    private enum QueryItem {
        static let currency = "vs_currency"
        static let order = "order"
        static let orderValue = "market_cap_desc"
        static let perPage = "per_page"
    }

    private enum HTTPMethod: String {
        case get = "GET"
    }

    private enum Endpoint: String {
        case markets = "coins/markets"

        /// The string URL path of the selected endpoint.
        var path: String {
            let rootStringURL = "https://api.coingecko.com/api/v3/"

            switch self {
                case .markets:
                    return "\(rootStringURL)/\(rawValue)"
            }
        }
    }

    private let requestTimeoutInterval: TimeInterval = 10
}

// MARK: BackendServiceProtocol

extension BackendService: BackendServiceProtocol {
    // MARK: - Public APIs

    /// Fetches the coins by market cap in descending order.
    /// - Parameters:
    ///   - currency: The target currency of coins and market data.
    ///   - numberOfCoins: The total number of coins to fetch.
    ///   - priceChangePercentage: The price change percentage timeframe.
    /// - Returns: If successful, returns an array of the top coins by market cap. Otherwise, returns a `NetworkError`.
    func fetchTopCryptocurrencies(currency: String, numberOfCoins: Int) async -> Result<[CryptoDTO], NetworkError> {
        guard
            let url = URL(string: Endpoint.markets.path),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return .failure(NetworkError.badURL)
        }

        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: QueryItem.currency, value: currency),
            URLQueryItem(name: QueryItem.order, value: QueryItem.orderValue),
            URLQueryItem(name: QueryItem.perPage, value: "\(numberOfCoins)"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        guard let componentsURL = components.url else {
            return .failure(NetworkError.badURL)
        }

        var request = URLRequest(url: componentsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = requestTimeoutInterval
        request.allHTTPHeaderFields = [
            acceptHeaderFieldKey: acceptHeaderFieldValue,
            APIKeyQueryParameter: APIKey,
        ]

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode {
                let topCryptos = try? JSONDecoder().decode([CryptoDTO].self, from: data)
                return .success(topCryptos ?? [])

            } else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                return .failure(NetworkError.responseUnsuccessful(statusCode: statusCode))
            }

        } catch {
            if let urlError = error as? URLError {
                return .failure(NetworkError.requestFailed(description: urlError.localizedDescription))
            } else {
                return .failure(NetworkError.unknown)
            }
        }
    }
}
