//
//  HomeViewModelTests.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

@testable import Trust
import XCTest

final class HomeViewModelTests: XCTestCase {
    private var sut: HomeViewModel!

    override func setUp() {
        super.setUp()

        sut = HomeViewModel()
    }

    override func tearDown() {

        sut = nil
        super.tearDown()
    }

    func test_init() {
        // Given
        sut = HomeViewModel()

        // Then
        XCTAssertEqual(sut.popularTokensRequestState, .idle)
    }
}
