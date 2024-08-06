//
//  SettingsRowView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct SettingsRowView: View {
    var title: LocalizedStringKey
    var iconName: String
    var didTap: () -> Void

    var body: some View {
        Button {
            didTap()
        } label: {
            HStack {
                Image(systemName: iconName)
                    .foregroundStyle(Color.secondary)

                Text(title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.forward")
                    .foregroundStyle(Color.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .contentShape(Rectangle())
    }
}

#Preview {
    SettingsRowView(title: .placeholder, iconName: "gear", didTap: {})
}
