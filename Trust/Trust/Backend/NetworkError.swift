//
//  NetworkError.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

enum NetworkError: Error, Equatable {
    case badURL
    case requestFailed(description: String)
    case responseUnsuccessful(statusCode: Int)
    case dataParsingFailed(description: String)
    case unknown

    var localizedDescription: LocalizedStringKey {
        switch self {
            case .badURL:
                LocalizedStringKey("networkError_badURL")
            case let .requestFailed(description):
                LocalizedStringKey("networkError_requestFailed \(description)")
            case let .responseUnsuccessful(statusCode):
                LocalizedStringKey("networkError_responseUnsuccessful \(statusCode)")
            case let .dataParsingFailed(description):
                LocalizedStringKey("networkError_dataParsingFailed \(description)")
            case .unknown:
                LocalizedStringKey("networkError_unknown")
        }
    }
}
