//
//  CreateWalletView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct CreateWalletView: View {
    // MARK: - Private Properties

    @State private var navigator = Navigator()
    @Environment(\.dismiss) private var dismiss

    private let navigationTitle = LocalizedStringKey("createWalletView_navigationTitle")

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $navigator.path) {
            ZStack {
                Color(uiColor: .secondarySystemBackground)
                    .ignoresSafeArea()

                ScrollView {
                    ZStack {
                        Spacer()
                            // Extend scrollable content
                            .containerRelativeFrame(.vertical) { size, _ in
                                size
                            }

                        Text(.placeholder)
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateWalletView()
    }
}
