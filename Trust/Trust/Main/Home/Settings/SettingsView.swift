//
//  SettingsView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Public Properties

    var navigator: Navigator

    // MARK: - Private Properties

    private let navigationTitle = LocalizedStringKey("settingsView_navigationTitle")

    // MARK: - Body

    var body: some View {
        VStack {
            List {
                Section {
                    SettingsRowView(title: LocalizedStringKey("settingsView_preferences_title"), iconName: "gear") {
                        navigator.navigate(to: SettingsDestination.preferences)
                    }
                } footer: {
                    // Hairline
                    Rectangle()
                        .stroke(Color.secondary.opacity(0.2), lineWidth: 0.5)
                        .frame(height: 0.5)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(Constants.listRowInsets)
                .listRowSeparator(.hidden)
            }
            .listStyle(.grouped)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    navigator.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                }
            }
        }
        .navigationDestination(for: SettingsDestination.self) { destination in
            switch destination {
                case .preferences:
                    PreferencesView(navigator: navigator)
            }
        }
    }
}

#Preview {
    SettingsView(navigator: Navigator())
}
