//
//  PriceFormatter.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

class PriceFormatter {
    // MARK: - Shared Instance

    static let shared = PriceFormatter()

    // MARK: - Private Properties

    private var formatter: NumberFormatter

    // MARK: - Init

    private init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
    }

    // MARK: - Public APIs

    func formatPrice(_ value: Double, currencySymbol: String) -> String {
        formatter.currencySymbol = currencySymbol
        return formatter.string(from: NSNumber(value: value)) ?? "\(currencySymbol)\(value)"
    }
}
