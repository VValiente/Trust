//
//  DataParser.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

enum DataParser {
    static func parse(cryptoDTO: CryptoDTO, currencySymbol: String) -> PopularTokenViewData {
        PopularTokenViewData(
            id: cryptoDTO.id,
            imageURL: cryptoDTO.image,
            title: cryptoDTO.symbol.uppercased(),
            subtitle: cryptoDTO.name,
            price: displayCurrentPrice(from: currencySymbol, currentPrice: cryptoDTO.currentPrice),
            priceChange: displayPriceChange(from: cryptoDTO.priceChangePercentage24h)
        )
    }

    // MARK: - Private APIs

    private static func displayCurrentPrice(from currencySymbol: String, currentPrice: Double?) -> String {
        guard let currentPrice else {
            return ""
        }

        return PriceFormatter.shared.formatPrice(currentPrice, currencySymbol: currencySymbol)
    }

    private static func displayPriceChange(from priceChangePercentage: Double?) -> Double {
        guard let priceChangePercentage else {
            return 0.0
        }

        return (priceChangePercentage * 100).rounded() / 100
    }
}
