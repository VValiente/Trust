//
//  HomeViewModelTests.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

import Combine
@testable import Trust
import XCTest

// swiftformat:options --selfrequired withContinousObservation
final class HomeViewModelTests: XCTestCase {
    private var sut: HomeViewModel!
    private var mockBackendService: MockBackendService!
    private var mockTopCryptoState: MockTopCryptoState!

    private var popularTokensRequestState: HomeViewModel.RequestState!
    private var idleExpectation: XCTestExpectation!
    private var loadingExpectation: XCTestExpectation!
    private var successExpectation: XCTestExpectation!
    private var failureExpectation: XCTestExpectation!
    private var successViewData: [PopularTokenViewData]!

    override func setUp() {
        super.setUp()

        mockBackendService = MockBackendService()
        mockTopCryptoState = MockTopCryptoState()
        idleExpectation = XCTestExpectation(description: "Idle state")
        loadingExpectation = XCTestExpectation(description: "Loading state")
        successExpectation = XCTestExpectation(description: "Success state")
        failureExpectation = XCTestExpectation(description: "Failure state")
        successViewData = []

        sut = HomeViewModel(backendService: mockBackendService, topCrytoState: mockTopCryptoState)
    }

    override func tearDown() {
        sut = nil
        mockBackendService = nil
        mockTopCryptoState = nil

        popularTokensRequestState = nil
        idleExpectation = nil
        loadingExpectation = nil
        successExpectation = nil
        failureExpectation = nil
        successViewData = nil

        super.tearDown()
    }

    func test_init() {
        // Given
        sut = HomeViewModel()

        // Then
        XCTAssertEqual(sut.popularTokensRequestState, .idle)
    }

    func test_fetchPopularTokens_success() async {
        // Given
        let expectations: [XCTestExpectation] = [
            idleExpectation,
            loadingExpectation,
            successExpectation,
        ]
        let mockedData: [CryptoDTO] = [
            CryptoDTO.TestData.bitcoin,
            CryptoDTO.TestData.ethereum,
        ]
        mockBackendService.data = mockedData
        mockBackendService.networkError = nil
        XCTAssertEqual(mockTopCryptoState.topCryptos, [])
        XCTAssertEqual(successViewData, [])

        withContinousObservation(of: self.sut.popularTokensRequestState) { state in
            switch state {
                case .idle:
                    self.idleExpectation.fulfill()

                case .loading:
                    self.loadingExpectation.fulfill()

                case let .success(data):
                    self.successViewData = data
                    self.successExpectation.fulfill()

                case .failure:
                    self.failureExpectation.fulfill()
            }
        }

        // When
        sut.fetchPopularTokens()

        // Then
        await fulfillment(of: expectations)
        XCTAssertEqual(mockTopCryptoState.topCryptos, mockedData)
        XCTAssertEqual(successViewData, mockedData.map { DataParser.parse(cryptoDTO: $0, currencySymbol: "$") })
    }

    func test_fetchPopularTokens_failure() async {
        // Given
        let expectations: [XCTestExpectation] = [
            idleExpectation,
            loadingExpectation,
            failureExpectation,
        ]
        mockBackendService.data = []
        mockBackendService.networkError = .unknown
        XCTAssertEqual(mockTopCryptoState.topCryptos, [])
        XCTAssertEqual(successViewData, [])

        withContinousObservation(of: self.sut.popularTokensRequestState) { state in
            switch state {
                case .idle:
                    self.idleExpectation.fulfill()

                case .loading:
                    self.loadingExpectation.fulfill()

                case let .success(data):
                    self.successViewData = data
                    self.successExpectation.fulfill()

                case .failure:
                    self.failureExpectation.fulfill()
            }
        }

        // When
        sut.fetchPopularTokens()

        // Then
        await fulfillment(of: expectations)
        XCTAssertEqual(mockTopCryptoState.topCryptos, [])
        XCTAssertEqual(successViewData, [])
    }
}
