//
//  PopularTokenRowViewModel.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import Observation
import SwiftUI

@Observable
final class PopularTokenRowViewModel {
    var iconState: IconState = .idle
    enum IconState {
        case idle
        case loading
        case success(UIImage)
        case failure
    }
}
