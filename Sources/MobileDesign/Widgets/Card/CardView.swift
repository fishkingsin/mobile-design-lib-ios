//
// CardView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct CardView<Data>: View where Data: CardDisplayable {
    var data: Data
    public init(data: Data) {
        self.data = data
    }
    public var body: some View {
        TopImageCardView(imageUrl: data.imageURL, imageWidth: nil, imageHeight: 200) {
            // MARK: update placeholder
            Image("TopImageCardViewPlaceholder", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: 200)
                .clipped()
        } contentView: {
            CardContentView(
                headline: data.headline,
                leadingFootnote: data.leadingFootnote,
                secondFootnote: data.secondFootnote
            )
        } overlayView: {
            EmptyView()
        }

        .padding(16)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView<CardData>(data: CardData(imageURL: "", headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式", leadingFootnote: "4小時前", secondFootnote: "經人觀點"))
    }
}
