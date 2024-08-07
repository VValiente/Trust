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
    // MARK: - Public Properties

    var iconState: IconState = .idle
    enum IconState {
        case idle
        case loading
        case success(UIImage)
        case failure
    }

    // MARK: - Private Properties

    private let imageLoader = ImageLoader()

    // MARK: - Public APIs

    func loadIcon(from url: URL?) {
        guard let url else {
            return
        }

        iconState = .loading

        Task {
            let result = await imageLoader.loadImage(from: url)
            switch result {
                case let .success(uiImage):
                    iconState = .success(uiImage)

                case .failure:
                    iconState = .failure
            }
        }
    }
}
