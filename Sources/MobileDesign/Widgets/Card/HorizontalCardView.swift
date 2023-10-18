//
//  HorizontalCardView.swift
//  
//
//  Created by Felix Fok Ka Chun on 19/9/2023.
//

import SwiftUI

struct HorizontalCardView<PlaceholderView: View, ContentView: View, OverlayView: View>: View
{
    let imageUrl: String
    
    let overLayViewAlign: Alignment
    let placeholderView: () -> PlaceholderView
    let contentView: () -> ContentView
    let overlayView: (() -> OverlayView)?

    public init(
      imageUrl: String,
      overLayViewAlign: Alignment,
      placeholderView: @escaping () -> PlaceholderView,
      contentView: @escaping () -> ContentView,
      overlayView: (() -> OverlayView)? = nil
    ) {
      self.imageUrl = imageUrl
      self.placeholderView = placeholderView
      self.contentView = contentView
      self.overlayView = overlayView
        self.overLayViewAlign = overLayViewAlign
    }
    
    public var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
              if let url = URL(string: imageUrl) {
                AsyncImageURLCachedView(url: url) {
                  getPlaceholder()
                } image: {
                  Image(uiImage: $0)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 133, maxHeight: 75)
                    .clipped()
                    .cornerRadius(4).overlay(alignment: overLayViewAlign) {
                        overlayView?() 
                    }
                }
              } else {
                getPlaceholder()
              }
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


struct HorizontalCardView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCardView(imageUrl: "https://placehold.co/133x75/png",
                           overLayViewAlign: .center) {
            Rectangle()
                .foregroundColor(.red)
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 75)
                .clipped()
                .cornerRadius(4)
        } contentView: {
            Text("Content")
        } overlayView: {
            Text("overlay")
        }
    }
}
