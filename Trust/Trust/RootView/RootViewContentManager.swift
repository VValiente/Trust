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
    static let shared = RootViewContentManager()

    var currentRoot: RootContentType = .splash
}
