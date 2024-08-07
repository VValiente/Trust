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

    @State private var viewModel = HomeViewModel()
    @State private var showCreateWalletView = false
    @State private var showAddWalletView = false

    private let title = LocalizedStringKey("homeView_title")
    private let earnPoints = LocalizedStringKey("wallet_earnPoints")

    // MARK: - Body

    var body: some View {
        List {
            Section {
                // Create Wallet Button
                WalletButton(
                    style: .create,
                    title: LocalizedStringKey("wallet_createButton_title"),
                    subtitle: LocalizedStringKey("wallet_createButton_subtitle"),
                    tagTitle: earnPoints,
                    didTap: {
                        showCreateWalletView = true
                    }
                )
                .padding(.vertical, .contentPadding)

                // Add Wallet Button
                WalletButton(
                    style: .add,
                    title: LocalizedStringKey("wallet_addButton_title"),
                    subtitle: LocalizedStringKey("wallet_addButton_subtitle"),
                    tagTitle: earnPoints,
                    didTap: {
                        showAddWalletView = true
                    }
                )
            } header: {
                VStack(alignment: .center, spacing: 28) {
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
                        .textCase(.none)
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(.zero)

            // List of Popular Tokens
            Section {
                PopularTokenRowView(
                    viewData: PopularTokenViewData(
                        id: "1",
                        imageURL: nil,
                        title: "BTC",
                        subtitle: "Bitcoin",
                        price: "$55,735.00",
                        priceChange: -9.43
                    ),
                    didTap: {}
                )

                PopularTokenRowView(
                    viewData: PopularTokenViewData(
                        id: "1",
                        imageURL: nil,
                        title: "BTC",
                        subtitle: "Bitcoin",
                        price: "$55,735.00",
                        priceChange: -9.43
                    ),
                    didTap: {}
                )
            } header: {
                Text(LocalizedStringKey("homeView_popularTokens_sectionTitle"))
                    .font(.title3)
                    .textCase(.none)
                    .padding(.vertical, .contentPadding)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(Constants.listRowInsets)
        }
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigator.navigate(to: HomeDestination.settings)
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $showCreateWalletView, onDismiss: {
            showCreateWalletView = false
        }) {
            CreateWalletView()
        }
        .sheet(isPresented: $showAddWalletView, onDismiss: {
            showAddWalletView = false
        }) {
            AddWalletView()
        }
        .navigationDestination(for: HomeDestination.self) { destination in
            switch destination {
                case .settings:
                    SettingsView(navigator: navigator)
            }
        }
        .task {
            viewModel.fetchPopularTokens()
        }
    }
}

#Preview {
    MainView(selectedTab: .home)
}
