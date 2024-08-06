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
            Text(verbatim: "Settings")
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
    }
}

#Preview {
    SettingsView(navigator: Navigator())
}
