//
//  PreferencesView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct PreferencesView: View {
    // MARK: - Public Properties

    var navigator: Navigator

    // MARK: - Private Properties

    private let navigationTitle = LocalizedStringKey("preferencesView_navigationTitle")

    // MARK: - Body

    var body: some View {
        VStack {
            Text(verbatim: "Preferences")
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
    PreferencesView(navigator: Navigator())
}
