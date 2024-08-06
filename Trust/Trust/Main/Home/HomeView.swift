//
//  HomeView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Public Properties

    var navigator: Navigator

    // MARK: - Body

    var body: some View {
        VStack {
            Text(verbatim: "Home")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigator.navigate(to: HomeDestination.settings)
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .navigationDestination(for: HomeDestination.self) { destination in
            switch destination {
                case .settings:
                    SettingsView(navigator: navigator)
            }
        }
    }
}

#Preview {
    MainView(selectedTab: .home)
}
