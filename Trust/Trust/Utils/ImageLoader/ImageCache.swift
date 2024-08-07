//
//  ImageCache.swift
//  Trust
//
//  Created by Vilma Valiente on 7/8/24.
//

import SwiftUI

class ImageCache {
    // MARK: - Shared Instance

    static let shared = ImageCache()

    // MARK: - Private Properties

    private typealias CacheType = NSCache<NSString, UIImage>
    private var imageCache: NSCache<NSString, UIImage> = {
        let cache = CacheType()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()

    // MARK: - Public APIs

    func cache(image: UIImage, key: NSString) {
        imageCache.setObject(image, forKey: key)
    }

    func cachedImage(for key: NSString) -> UIImage? {
        imageCache.object(forKey: key)
    }

    func removeCachedImage(for key: NSString) {
        imageCache.removeObject(forKey: key)
    }

    func removeAllCachedObjects() {
        imageCache.removeAllObjects()
    }
}
