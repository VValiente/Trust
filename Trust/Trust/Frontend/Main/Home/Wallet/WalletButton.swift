//
//  WalletButton.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct WalletButton: View {
    // MARK: - Public Properties

    var style: Style
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var tagTitle: LocalizedStringKey
    var didTap: () -> Void

    enum Style {
        case create
        case add
    }

    // MARK: - Private Properties

    private var iconName: String {
        switch style {
            case .create:
                "plus"
            case .add:
                "arrow.down"
        }
    }

    // MARK: - Body

    var body: some View {
        Button {
            didTap()
        } label: {
            HStack(spacing: 12) {
                // Icon
                Image(systemName: iconName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(10)
                    .background(
                        Circle()
                            .foregroundStyle(Color.blue.opacity(0.2))
                    )

                // Text
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.primary)
                            .frame(alignment: .leading)
                            .multilineTextAlignment(.leading)

                        Text(tagTitle)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundStyle(.gray.opacity(0.2))
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Text(subtitle)
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding([.vertical, .leading], .contentPadding)
        .padding(.trailing, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    WalletButton(
        style: .create,
        title: .placeholder,
        subtitle: .placeholder,
        tagTitle: .placeholder,
        didTap: {}
    )
    .padding()
}
