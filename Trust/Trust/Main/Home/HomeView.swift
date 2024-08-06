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
    private let earnPoints = LocalizedStringKey("wallet_earnPoints")

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: .contentPadding) {
                // Image
                Image(systemName: "shield.lefthalf.filled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .foregroundStyle(.tint)
                    .padding()

                // Title
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

                // Create Wallet Button
                WalletButton(
                    style: .create,
                    title: LocalizedStringKey("wallet_createButton_title"),
                    subtitle: LocalizedStringKey("wallet_createButton_subtitle"),
                    tagTitle: earnPoints
                )

                // Add Wallet Button
                WalletButton(
                    style: .add,
                    title: LocalizedStringKey("wallet_addButton_title"),
                    subtitle: LocalizedStringKey("wallet_addButton_subtitle"),
                    tagTitle: earnPoints
                )
            }
            .padding(.horizontal, .horizontalPadding)
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
