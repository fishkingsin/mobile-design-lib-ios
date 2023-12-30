//
//  AsyncImageLoaderURLCachedTests.swift
//  
//
//  Created by James Kong on 21/11/2023.
//

import XCTest
import Combine
import Foundation
@testable import MobileDesign

final class AsyncImageLoaderURLCachedTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testLoadImageFromCache() {
        let url = URL(string: "https://placehold.co/133x75/png?text=\(UUID().uuidString)")!
        let cache = URLCache.shared

        let imageLoader = AsyncImageLoaderURLCached(url: url, cache: cache)

        imageLoader.load()
        let expectation = XCTestExpectation(description: "Download image expectation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let loadedImage = imageLoader.loadImageFromCache(imageURL: url)

            XCTAssertNotNil(loadedImage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0) // Adjust the timeout as per your requirement
    }

    func testDownloadImage() {
        let url = URL(string: "https://placehold.co/133x75/png")!
        let cache = URLCache.shared
        let imageLoader = AsyncImageLoaderURLCached(url: url, cache: cache)

        let expectation = XCTestExpectation(description: "Download image expectation")

        let cancellable = imageLoader.downloadImage(url: url)
        cancellable.store(in: &cancellables)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(imageLoader.image, "Downloaded image should not be nil")
            expectation.fulfill()

        }

        wait(for: [expectation], timeout: 5.0) // Adjust the timeout as per your requirement
    }

}
