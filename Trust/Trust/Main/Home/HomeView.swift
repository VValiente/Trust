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

    // MARK: - Private Properties

    private let title = LocalizedStringKey("homeView_title")

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                Image(systemName: "shield.lefthalf.filled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .foregroundStyle(.tint)
                    .padding()

                Text(title)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .horizontalPadding)
            }
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
