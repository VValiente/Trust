//
//  PopularTokenRowView.swift
//  Trust
//
//  Created by Vilma Valiente on 6/8/24.
//

import SwiftUI

struct PopularTokenRowView: View {
    // MARK: - Public Properties

    var imageURL: URL?
    var title: String
    var subtitle: String
    var price: String
    var priceChange: Double
    var didTap: () -> Void

    // MARK: - Private Properties

    @State private var viewModel = PopularTokenRowViewModel()

    // MARK: - Body

    var body: some View {
        Button {
            didTap()
        } label: {
            HStack {
                // Image
                Group {
                    switch viewModel.iconState {
                        case .idle,
                             .failure:
                            ZStack {
                                Image(systemName: "photo")
                                    .font(.title2)
                            }

                        case .loading:
                            ProgressView()

                        case let .success(image):
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40)
                                .clipShape(Circle())
                    }
                }
                .padding(10)
                .background(
                    Circle()
                        .foregroundStyle(Color.blue.opacity(0.2))
                )

                // Token Name
                VStack(alignment: .leading, spacing: 4) {
                    Text(verbatim: title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(verbatim: subtitle)
                        .font(.body)
                        .foregroundStyle(Color.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Price action
                VStack(alignment: .trailing, spacing: 4) {
                    Text(verbatim: price)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary)
                        .frame(alignment: .leading)

                    Text(verbatim: "\(priceChange > 0 ? "+" : "")\(priceChange)%")
                        .font(.body)
                        .foregroundStyle(priceChange > 0 ? Color.green : Color.red)
                }
            }
        }
        .padding(.vertical, .rowItemVerticalPadding)
    }
}

#Preview {
    PopularTokenRowView(
        imageURL: nil,
        title: "BTC",
        subtitle: "Bitcoin",
        price: "$55,735.00",
        priceChange: -9.43,
        didTap: {}
    )
}
