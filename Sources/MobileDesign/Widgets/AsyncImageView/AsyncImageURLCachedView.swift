//
// AsyncImageURLCachedView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import UIKit
import SwiftUI

/// replace by URLCache https://levelup.gitconnected.com/image-caching-with-urlcache-4eca5afb543a
public struct AsyncImageURLCachedView<Placeholder: View, Content: View>: View {

    @ObservedObject private var loader: AsyncImageLoaderURLCached
    private let placeholder: Placeholder
    private let image: (UIImage) -> Content

    @Environment(\.colorScheme) private var colorScheme

    public init(
        url: URL,
        sync: Bool = false,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Content
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = ObservedObject(wrappedValue: AsyncImageLoaderURLCached(url: url))
    }

    public var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                colorScheme == .light ? image(loader.image!) : image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}
