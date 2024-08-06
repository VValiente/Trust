//
//  Navigator.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

@Observable
final class Navigator {
    var path = NavigationPath()

    func navigate(to destination: any Destination) {
        path.append(destination)
    }

    func navigateBack() {
        guard !path.isEmpty else {
            return
        }

        path.removeLast()
    }

    func navigateToRoot() {
        guard !path.isEmpty else {
            return
        }

        path.removeLast(path.count)
    }
}
