//
//  SplashScreenView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct SplashScreenView: View {
    // MARK: - Private Properties

    @State private var isIconAnimating = false

    // MARK: - Body

    var body: some View {
        Image(systemName: "shield.lefthalf.filled")
            .resizable()
            .scaledToFit()
            .frame(width: 160, height: 160)
            .symbolEffect(.pulse, options: .repeating, value: isIconAnimating)
            .foregroundStyle(.tint)
            .padding()
            .onAppear {
                isIconAnimating.toggle()
            }
    }
}

#Preview {
    SplashScreenView()
}
