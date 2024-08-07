//
//  LauncherView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct LauncherView: View {
    // MARK: - Private Properties

    @State private var contentRootManager = RootViewContentManager.shared

    // MARK: - Body

    var body: some View {
        Group {
            switch contentRootManager.currentRoot {
                case .splash:
                    SplashScreenView()

                case let .main(selectedTab):
                    MainView(selectedTab: selectedTab)
            }
        }
    }
}

#Preview {
    LauncherView()
}
