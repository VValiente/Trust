//
//  RootViewContentManager.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import Observation
import SwiftUI

@Observable
final class RootViewContentManager: RootViewContentProtocol {
    // MARK: - Shared Instance

    static let shared = RootViewContentManager()

    // MARK: - Public Properties

    var currentRoot: RootContentType = .splash
}
