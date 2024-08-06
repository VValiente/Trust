//
//  MainView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct MainView: View {
    // MARK: - Private Properties

    @State private var selectedTab: TabType

    // MARK: - Private Properties

    @State private var navigationManager: NavigationManager

    // MARK: - Init

    init(
        selectedTab: TabType,
        navigationManager: NavigationManager = NavigationManager()
    ) {
        self.selectedTab = selectedTab
        self.navigationManager = navigationManager
    }

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            NavigationStack(path: $navigationManager.homeNavigator.path) {
                HomeView(navigator: navigationManager.homeNavigator)
            }
            .tabItem {
                TabType.home.image
                Text(TabType.home.title)
            }
            .tag(TabType.home)

            // Swap Tab
            NavigationStack(path: $navigationManager.swapNavigator.path) {
                SwapView()
            }
            .tabItem {
                TabType.swap.image
                Text(TabType.swap.title)
            }
            .tag(TabType.swap)

            // Earn Tab
            NavigationStack(path: $navigationManager.earnNavigator.path) {
                EarnView()
            }
            .tabItem {
                TabType.earn.image
                Text(TabType.earn.title)
            }
            .tag(TabType.earn)

            // Discover Tab
            NavigationStack(path: $navigationManager.discoverNavigator.path) {
                DiscoverView()
            }
            .tabItem {
                TabType.discover.image
                Text(TabType.discover.title)
            }
            .tag(TabType.discover)
        }
        .onChange(of: selectedTab) {
            print("selectedTab: \(selectedTab)")
        }
    }
}

#Preview {
    MainView(selectedTab: .discover)
}
