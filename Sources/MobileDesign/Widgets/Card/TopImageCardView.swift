//
// TopImageCardView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct TopImageCardView<PlaceholderView: View, ContentView: View>: View {

    let imageUrl: String
    let imageWidth: CGFloat?
    let imageHeight: CGFloat?
    let placeholderView: () -> PlaceholderView
    let contentView: () -> ContentView

    public init(imageUrl: String, imageWidth: CGFloat?, imageHeight: CGFloat?, placeholderView: @escaping () -> PlaceholderView, contentView: @escaping () -> ContentView) {
        self.imageUrl = imageUrl
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.placeholderView = placeholderView
        self.contentView = contentView
    }

    public var body: some View {
        VStack(spacing: 0) {
            if let url = URL(string: imageUrl) {
                AsyncImageURLCachedView(url: url) {
                    getPlaceholder()
                } image: {
                    Image(uiImage: $0)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: imageWidth, maxHeight: imageHeight)
                        .clipped()
                }
            } else {
                getPlaceholder()
            }
            contentView()
        }
    }
    
    private func getPlaceholder() -> AnyView {
        AnyView(
            placeholderView()

        )
    }
}




struct TopImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        TopImageCardView(imageUrl: "", imageWidth: nil, imageHeight: 200) {
            Image("TopImageCardViewPlaceholder", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: 200)
                .clipped()
        } contentView: {
            Text("Content View")
                .padding()
        }.background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray.opacity(0.5), lineWidth: 1)
        )
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.5), radius: 20)
        .padding()
    }
}
