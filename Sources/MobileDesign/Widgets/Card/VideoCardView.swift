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
        List {
            ForEach(1...100, id: \.self) { i in
                VideoCardView<CardData>(data: CardData(
                    imageURL: ( i % 2 == 0 ) ? "" : "https://placehold.co/358x200/png?text=\(i)",
                    headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                    leadingFootnote: "4小時前",
                    secondFootnote: "經人觀點",
                    timecode: "22:22"
                ), onTabChanged: {
                    debugPrint("22:22")
                })
                .listSeparatorStyle(.none)

            }
        }.listStyle(.plain)

    }
}
