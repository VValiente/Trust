//
//  CryptoDTO.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

// MARK: - CryptoDTO

struct CryptoDTO: Identifiable, Equatable {
    let id: String
    let symbol: String
    let name: String
    let image: URL?
    let currentPrice: Double?
    let marketCap: Double?
    let marketCapRank: Int?
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24h: Double?
    let low24h: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    let marketCapChange24h: Double?
    let marketCapChangePercentage24h: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?

    init(
        id: String,
        symbol: String,
        name: String,
        image: URL? = nil,
        currentPrice: Double? = nil,
        marketCap: Double? = nil,
        marketCapRank: Int? = nil,
        fullyDilutedValuation: Double? = nil,
        totalVolume: Double? = nil,
        high24h: Double? = nil,
        low24h: Double? = nil,
        priceChange24h: Double? = nil,
        priceChangePercentage24h: Double? = nil,
        marketCapChange24h: Double? = nil,
        marketCapChangePercentage24h: Double? = nil,
        circulatingSupply: Double? = nil,
        totalSupply: Double? = nil,
        maxSupply: Double? = nil,
        ath: Double? = nil,
        athChangePercentage: Double? = nil,
        athDate: String? = nil,
        atl: Double? = nil,
        atlChangePercentage: Double? = nil,
        atlDate: String? = nil,
        lastUpdated: String? = nil
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.marketCapRank = marketCapRank
        self.fullyDilutedValuation = fullyDilutedValuation
        self.totalVolume = totalVolume
        self.high24h = high24h
        self.low24h = low24h
        self.priceChange24h = priceChange24h
        self.priceChangePercentage24h = priceChangePercentage24h
        self.marketCapChange24h = marketCapChange24h
        self.marketCapChangePercentage24h = marketCapChangePercentage24h
        self.circulatingSupply = circulatingSupply
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.ath = ath
        self.athChangePercentage = athChangePercentage
        self.athDate = athDate
        self.atl = atl
        self.atlChangePercentage = atlChangePercentage
        self.atlDate = atlDate
        self.lastUpdated = lastUpdated
    }
}

// MARK: Codable

extension CryptoDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        symbol = try container.decode(String.self, forKey: .symbol)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(URL.self, forKey: .image)

        if let price = try? container.decode(Double.self, forKey: .currentPrice) {
            currentPrice = price
        } else if let priceInt = try? container.decode(Int.self, forKey: .currentPrice) {
            currentPrice = Double(priceInt)
        } else {
            currentPrice = 0.0
        }

        marketCap = try? container.decode(Double.self, forKey: .marketCap)
        marketCapRank = try? container.decode(Int.self, forKey: .marketCapRank)
        fullyDilutedValuation = try? container.decode(Double.self, forKey: .fullyDilutedValuation)
        totalVolume = try? container.decode(Double.self, forKey: .totalVolume)
        high24h = try? container.decode(Double.self, forKey: .high24h)
        low24h = try? container.decode(Double.self, forKey: .low24h)
        priceChange24h = try? container.decode(Double.self, forKey: .priceChange24h)
        priceChangePercentage24h = try? container.decode(Double.self, forKey: .priceChangePercentage24h)
        marketCapChange24h = try? container.decode(Double.self, forKey: .marketCapChange24h)
        marketCapChangePercentage24h = try? container.decode(Double.self, forKey: .marketCapChangePercentage24h)
        circulatingSupply = try? container.decode(Double.self, forKey: .circulatingSupply)
        totalSupply = try? container.decode(Double.self, forKey: .totalSupply)
        maxSupply = try? container.decode(Double.self, forKey: .maxSupply)
        ath = try? container.decode(Double.self, forKey: .ath)
        athChangePercentage = try? container.decode(Double.self, forKey: .athChangePercentage)
        athDate = try? container.decode(String.self, forKey: .athDate)
        atl = try? container.decode(Double.self, forKey: .atl)
        atlChangePercentage = try? container.decode(Double.self, forKey: .atlChangePercentage)
        atlDate = try? container.decode(String.self, forKey: .atlDate)
        lastUpdated = try? container.decode(String.self, forKey: .lastUpdated)
    }
}
