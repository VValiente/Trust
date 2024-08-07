//
//  PopularTokenViewData.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

struct PopularTokenViewData: Hashable {
    var id: String
    var imageURL: URL?
    var title: String
    var subtitle: String
    var price: String
    var priceChange: Double
}
