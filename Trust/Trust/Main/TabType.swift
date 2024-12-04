//
//  TabType.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

enum TabType {
    case home
    case swap
    case earn
    case discover

    var image: Image {
        switch self {
            case .home:
                Image(systemName: "house")
            case .swap:
                Image(systemName: "arrow.left.arrow.right")
            case .earn:
                Image(systemName: "banknote")
            case .discover:
                Image(systemName: "magnifyingglass")
        }
    }

    var title: LocalizedStringKey {
        switch self {
            case .home:
                LocalizedStringKey("tab_home")
            case .swap:
                LocalizedStringKey("tab_swap")
            case .earn:
                LocalizedStringKey("tab_earn")
            case .discover:
                LocalizedStringKey("tab_discover")
        }
    }
}
