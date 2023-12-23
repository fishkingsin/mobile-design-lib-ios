//
// AsyncImageLoaderURLCached.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit
import Combine

class AsyncImageLoaderURLCached: ObservableObject {
    @Published var image: UIImage?

    private(set) var isLoading = false

    private let url: URL
    private var cache: URLCache?
    private var cancellable: AnyCancellable?

    private static let imageProcessingQueue = DispatchQueue(label: "image-processing", attributes: .concurrent)

    init(url: URL, cache: URLCache = URLCache.shared) {
        self.url = url
        self.cache = cache
    }

    deinit {
        cancel()
    }

    func load() {
        guard !isLoading else { return }

        let request = URLRequest(url: url)

        if cache?.cachedResponse(for: request) != nil {
            image = loadImageFromCache(imageURL: url)
            return
        }

        cancellable = downloadImage(url: url)
    }

    func cancel() {
        cancellable?.cancel()
    }

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }

    func downloadImage(url: URL) -> AnyCancellable {
        let request = URLRequest(url: url)
        return URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.onStart() },
                receiveOutput: { [weak self] output in
                    let data = output.data
                    let response = output.response
                    let cachedData = CachedURLResponse(response: response, data: data)
                    self?.cache?.storeCachedResponse(cachedData, for: request)

                },
                receiveCompletion: { [weak self] _ in self?.onFinish() },
                receiveCancel: { [weak self] in self?.onFinish() }
            )
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .sink { [weak self] in self?.image = $0 }
    }

    func loadImageFromCache(imageURL: URL) -> UIImage? {
        let request = URLRequest(url: imageURL)
        guard let data = cache?.cachedResponse(for: request)?.data,
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}
