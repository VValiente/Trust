//
//  SplashScreenViewModel.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

final class SplashScreenViewModel {
    // MARK: - Private Properties

    private var rootViewContentManager: RootViewContentProtocol

    // MARK: - Init

    init(rootViewContentManager: RootViewContentProtocol = RootViewContentManager.shared) {
        self.rootViewContentManager = rootViewContentManager
    }

    // MARK: - Public APIs

    func loadData() {
        // Load data if needed

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Fake delay
            self.rootViewContentManager.currentRoot = .main(.home)
        }
    }
}
