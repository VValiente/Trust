//
//  MainView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct MainView: View {
    // MARK: - Private Properties

    @State var selectedTab: TabType

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    TabType.home.image
                    Text(TabType.home.title)
                }
                .tag(TabType.home)

            SwapView()
                .tabItem {
                    TabType.swap.image
                    Text(TabType.swap.title)
                }
                .tag(TabType.swap)

            EarnView()
                .tabItem {
                    TabType.earn.image
                    Text(TabType.earn.title)
                }
                .tag(TabType.earn)

            DiscoverView()
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
