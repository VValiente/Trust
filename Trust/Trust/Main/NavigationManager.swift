//
//  NavigationManager.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

@Observable
final class NavigationManager {
    // MARK: - Public Properties

    var homeNavigator = Navigator()
    var swapNavigator = Navigator()
    var earnNavigator = Navigator()
    var discoverNavigator = Navigator()
}
