//
//  UINavigationController+Extensions.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

/// When using a custom navigation back button, the edge swipe no longer works.
/// This extension brings back the edge swipe behavior to go back.
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
