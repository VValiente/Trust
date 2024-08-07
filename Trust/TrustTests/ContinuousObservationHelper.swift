//
//  ContinuousObservationHelper.swift
//  TrustTests
//
//  Created by Vilma Valiente on 7/8/24.
//

import Foundation

/// This is used for continuously observing properties of an `@Observable` object.
/// - Parameters:
///   - value: The value to be observed.
///   - execute: The closure that defines what actions should be performed whenever the observed value changes.
func withContinousObservation<T>(of value: @escaping @autoclosure () -> T, execute: @escaping (T) -> Void) {
    withObservationTracking {
        execute(value())
    } onChange: {
        Task { @MainActor in
            withContinousObservation(of: value(), execute: execute)
        }
    }
}
