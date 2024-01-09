//
// VideoCardView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct VideoCardView<Data>: View where Data: CardDisplayable {
    var data: Data
    var onTabChanged: () -> Void

    public init(data: Data, onTabChanged: @escaping () -> Void) {
        self.data = data
        self.onTabChanged = onTabChanged
    }
    public var body: some View {
        TopImageCardView(imageUrl: data.imageURL,
                         imageWidth: nil,
                         imageHeight: nil) {
            Image(ImageResource.placeholder)
                .resizable()
                .scaledToFill()
                .clipped()
                .cornerRadius(4)
        } contentView: {
            CardContentView(
                headline: data.headline,
                leadingFootnote: data.leadingFootnote,
                secondFootnote: data.secondFootnote
            )
        } overlayView: {
            EmptyView()
        }

        .onTapGesture {
            onTabChanged()
        }

    }
}

struct VideoCardView_Previews: PreviewProvider {
    static var previews: some View {
        List(stride(from: 1, to: 100, by: 1).map { i in
            CardData(
                imageURL: ( i % 2 == 0 ) ? "" : "https://placehold.co/358x200/png?text=\(i)",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "22:22"
            )
        }) { data in
            VideoCardView<CardData>(data: data, onTabChanged: {
                debugPrint("22:22")
            })
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .listSeparatorStyle(.none)
            .listRowSeparator(.hidden)
            .background( data.imageURL.contains("13") ? .black.opacity(0.1) : .clear)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))

        }
        .listStyle(.plain)

    }
}
