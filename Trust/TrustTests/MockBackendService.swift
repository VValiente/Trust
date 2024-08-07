//
//  MockBackendService.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

@testable import Trust
import XCTest

class MockBackendService: BackendServiceProtocol {
    var data: [CryptoDTO] = []
    var networkError: NetworkError?

    func fetchTopCryptocurrencies(currency _: String, numberOfCoins _: Int) async -> Result<[CryptoDTO], NetworkError> {
        if let networkError {
            return .failure(networkError)
        }

        return .success(data)
    }
}
