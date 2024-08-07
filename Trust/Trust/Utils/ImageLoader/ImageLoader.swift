//
//  ImageLoader.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

@Observable
class ImageLoader {
    // MARK: - Private Properties

    private var task: URLSessionDataTask?

    // MARK: - deinit

    deinit {
        task?.cancel()
    }

    // MARK: - Public APIs

    func loadImage(from imageURL: URL) async -> Result<UIImage, Error> {
        if let cachedUIImage = ImageCache.shared.cachedImage(for: imageURL.absoluteString as NSString) {
            print("Cached image found for \(imageURL.lastPathComponent)")
            return .success(cachedUIImage)
        }

        return await withCheckedContinuation { continuation in
            task = URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let error {
                    print("Failed to download image from URL for \(imageURL.lastPathComponent).")
                    continuation.resume(returning: .failure(error))
                    return
                }

                if let data {
                    guard let uiImage = UIImage(data: data) else {
                        print("Failed to convert \(imageURL.lastPathComponent) to image.")
                        continuation.resume(returning: .failure(ImageError.invalidData))
                        return
                    }

                    continuation.resume(returning: .success(uiImage))
                    ImageCache.shared.cache(image: uiImage, key: imageURL.absoluteString as NSString)
                }
            }

            task?.resume()
        }
    }
}
