//
// TopImageCardView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct TopImageCardView<
  PlaceholderView: View, ContentView: View, OverlayView: View
>: View {

  let imageUrl: String
  let imageWidth: CGFloat?
  let imageHeight: CGFloat?
  let placeholderView: () -> PlaceholderView
  let contentView: () -> ContentView
  let overlayView: (() -> OverlayView)?
    let alignment: Alignment

  public init(
    imageUrl: String,
    imageWidth: CGFloat?,
    imageHeight: CGFloat?,
    alignment: Alignment? = .bottomTrailing,
    placeholderView: @escaping () -> PlaceholderView,
    contentView: @escaping () -> ContentView,
    overlayView: (() -> OverlayView)? = nil
  ) {
    self.imageUrl = imageUrl
    self.imageWidth = imageWidth
    self.imageHeight = imageHeight
      self.alignment = alignment ?? .bottomTrailing
    self.placeholderView = placeholderView
    self.contentView = contentView
    self.overlayView = overlayView
  }

  public var body: some View {
    VStack(spacing: 0) {
      ZStack(alignment: alignment) {
        if let url = URL(string: imageUrl) {
          AsyncImageURLCachedView(url: url) {
            getPlaceholder()
          } image: {
            Image(uiImage: $0)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(maxWidth: imageWidth, maxHeight: imageHeight)
              .clipped()
              .cornerRadius(4)
          }
        } else {
          getPlaceholder()
        }
        overlayView?()
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
      TopImageCardView(imageUrl: "", imageWidth: nil, imageHeight: 200, alignment: .topLeading) {
      Rectangle()
        .foregroundColor(.red)
        .aspectRatio(contentMode: .fill)
        .frame(maxHeight: 200)
        .clipped()
        .cornerRadius(4)
    } contentView: {
      Text("Content")
    } overlayView: {
      Text("overlay")
    }
    .shadow(color: .gray.opacity(0.5), radius: 20)
    .padding()
  }
}
