//
//  BackendServiceTests.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

@testable import Trust
import XCTest

// MARK: - BackendServiceTests

final class BackendServiceTests: XCTestCase {
    private var sut: BackendService!

    override func setUp() {
        super.setUp()

        // Set up the URLProtocol to use the mock class.
        URLProtocol.registerClass(MockURLProtocol.self)
        
        MockURLProtocol.resetMock()

        sut = BackendService()
    }

    override func tearDown() {
        // Unregister the mock URLProtocol class.
        URLProtocol.unregisterClass(MockURLProtocol.self)

        sut = nil
        super.tearDown()
    }

    func test_fetchTopCryptocurrencies_success() async throws {
        // Given
        let mockData = top5CryptoRawData
        MockURLProtocol.responseData = mockData
        MockURLProtocol.responseStatusCode = 200

        // When
        let result = await sut.fetchTopCryptocurrencies(currency: "usd", numberOfCoins: 5)

        // Then
        switch result {
            case let .success(cryptos):
                XCTAssertEqual(cryptos.count, 5)
                XCTAssertEqual(cryptos[0].id, "bitcoin")
                XCTAssertEqual(cryptos[1].id, "ethereum")
                XCTAssertEqual(cryptos[2].id, "tether")
                XCTAssertEqual(cryptos[3].id, "binancecoin")
                XCTAssertEqual(cryptos[4].id, "solana")

            case .failure:
                XCTFail("Expected success, got failure!")
        }
    }

    func test_fetchTopCryptocurrencies_responseUnsuccessful() async throws {
        // Given
        MockURLProtocol.responseStatusCode = 404
        MockURLProtocol.responseData = nil

        // When
        let result = await sut.fetchTopCryptocurrencies(currency: "usd", numberOfCoins: 5)

        // Then
        switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case let .failure(error):
                XCTAssertEqual(error, .responseUnsuccessful(statusCode: 404))
        }
    }

    func test_fetchTopCryptocurrencies_requestFailed() async throws {
        // Given
        let urlError = URLError(.timedOut)
        MockURLProtocol.error = urlError

        // When
        let result = await sut.fetchTopCryptocurrencies(currency: "usd", numberOfCoins: 1)

        // Then
        switch result {
            case .success:
                XCTFail("Expected failure, got success")

            case let .failure(error):
                if case let .requestFailed(description) = error {
                    XCTAssertEqual(description, urlError.localizedDescription)
                } else {
                    XCTFail("Expected requestFailed error")
                }
        }
    }

    func test_fetchTopCryptocurrencies_dataParsingFailed() async throws {
        // Given
        let invalidMockData = "invalid data".data(using: .utf8)!
        MockURLProtocol.responseData = invalidMockData
        MockURLProtocol.responseStatusCode = 200

        // When
        let result = await sut.fetchTopCryptocurrencies(currency: "usd", numberOfCoins: 1)

        // Then
        switch result {
            case .success:
                XCTFail("Expected failure, got success")

            case let .failure(error):
                if case let .dataParsingFailed(description) = error {
                    XCTAssertEqual(description, "The data couldn’t be read because it isn’t in the correct format.")
                } else {
                    XCTFail("Expected dataParsingFailed error")
                }
        }
    }

    func test_fetchTopCryptocurrencies_unknownError() async throws {
        // Given
        MockURLProtocol.error = NetworkError.badURL

        // When
        let result = await sut.fetchTopCryptocurrencies(currency: "usd", numberOfCoins: 1)

        // Then
        switch result {
            case .success:
                XCTFail("Expected failure, got success")

            case let .failure(error):
                XCTAssertEqual(error, .unknown)
        }
    }
}

private let top5CryptoRawData = """
    [
    {
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
    "current_price": 56768,
    "market_cap": 1125417792623,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1197455458531,
    "total_volume": 51185900729,
    "high_24h": 57267,
    "low_24h": 54578,
    "price_change_24h": 1060.84,
    "price_change_percentage_24h": 1.90431,
    "market_cap_change_24h": 21425625133,
    "market_cap_change_percentage_24h": 1.94074,
    "circulating_supply": 19736662,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 73738,
    "ath_change_percentage": -22.75926,
    "ath_date": "2024-03-14T07:10:36.635Z",
    "atl": 67.81,
    "atl_change_percentage": 83894.34873,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-08-07T06:19:55.700Z"
    },
    {
    "id": "ethereum",
    "symbol": "eth",
    "name": "Ethereum",
    "image": "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
    "current_price": 2497.6,
    "market_cap": 301713645396,
    "market_cap_rank": 2,
    "fully_diluted_valuation": 301713645396,
    "total_volume": 26680494714,
    "high_24h": 2546.39,
    "low_24h": 2423.07,
    "price_change_24h": -13.372914771002797,
    "price_change_percentage_24h": -0.53258,
    "market_cap_change_24h": -1683518416.3954468,
    "market_cap_change_percentage_24h": -0.55489,
    "circulating_supply": 120259132.658117,
    "total_supply": 120259132.658117,
    "max_supply": null,
    "ath": 4878.26,
    "ath_change_percentage": -48.47458,
    "ath_date": "2021-11-10T14:24:19.604Z",
    "atl": 0.432979,
    "atl_change_percentage": 580423.57873,
    "atl_date": "2015-10-20T00:00:00.000Z",
    "roi": {
    "times": 57.78779217109387,
    "currency": "btc",
    "percentage": 5778.779217109387
    },
    "last_updated": "2024-08-07T06:19:54.617Z"
    },
    {
    "id": "tether",
    "symbol": "usdt",
    "name": "Tether",
    "image": "https://coin-images.coingecko.com/coins/images/325/large/Tether.png?1696501661",
    "current_price": 0.999119,
    "market_cap": 114475094056,
    "market_cap_rank": 3,
    "fully_diluted_valuation": 114475094056,
    "total_volume": 62611356060,
    "high_24h": 1.009,
    "low_24h": 0.997159,
    "price_change_24h": -0.001218766253099246,
    "price_change_percentage_24h": -0.12184,
    "market_cap_change_24h": -101831035.87469482,
    "market_cap_change_percentage_24h": -0.08888,
    "circulating_supply": 114551170628.491,
    "total_supply": 114551170628.491,
    "max_supply": null,
    "ath": 1.32,
    "ath_change_percentage": -24.25099,
    "ath_date": "2018-07-24T00:00:00.000Z",
    "atl": 0.572521,
    "atl_change_percentage": 75.05586,
    "atl_date": "2015-03-02T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-08-07T06:19:54.615Z"
    },
    {
    "id": "binancecoin",
    "symbol": "bnb",
    "name": "BNB",
    "image": "https://coin-images.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970",
    "current_price": 492.62,
    "market_cap": 72262383206,
    "market_cap_rank": 4,
    "fully_diluted_valuation": 72262383206,
    "total_volume": 1609076574,
    "high_24h": 496.81,
    "low_24h": 470.98,
    "price_change_24h": 6.4,
    "price_change_percentage_24h": 1.31645,
    "market_cap_change_24h": 1354183321,
    "market_cap_change_percentage_24h": 1.90977,
    "circulating_supply": 145887575.79,
    "total_supply": 145887575.79,
    "max_supply": 200000000,
    "ath": 717.48,
    "ath_change_percentage": -30.96314,
    "ath_date": "2024-06-06T14:10:59.816Z",
    "atl": 0.0398177,
    "atl_change_percentage": 1243875.55584,
    "atl_date": "2017-10-19T00:00:00.000Z",
    "roi": null,
    "last_updated": "2024-08-07T06:19:43.882Z"
    },
    {
    "id": "solana",
    "symbol": "sol",
    "name": "Solana",
    "image": "https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1718769756",
    "current_price": 153.07,
    "market_cap": 71697081055,
    "market_cap_rank": 5,
    "fully_diluted_valuation": 89444464589,
    "total_volume": 6718573226,
    "high_24h": 154.68,
    "low_24h": 136.93,
    "price_change_24h": 10.86,
    "price_change_percentage_24h": 7.63756,
    "market_cap_change_24h": 5101137673,
    "market_cap_change_percentage_24h": 7.65983,
    "circulating_supply": 466236678.777554,
    "total_supply": 581645577.35716,
    "max_supply": null,
    "ath": 259.96,
    "ath_change_percentage": -40.77371,
    "ath_date": "2021-11-06T21:54:35.825Z",
    "atl": 0.500801,
    "atl_change_percentage": 30643.58082,
    "atl_date": "2020-05-11T19:35:23.449Z",
    "roi": null,
    "last_updated": "2024-08-07T06:19:39.152Z"
    }
    ]
    """
.data(using: .utf8)!
