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
        VStack {
            TopImageCardView(imageUrl: data.imageURL,
                             imageWidth: UIScreen.main.bounds.width - 32,
                             imageHeight: 9.0/16.0 * (UIScreen.main.bounds.width - 32)) {
                Rectangle().fill(.gray)
            } contentView: {
                CardContentView(
                    headline: data.headline,
                    leadingFootnote: data.leadingFootnote,
                    secondFootnote: data.secondFootnote,
                    cardContentType: .other
                )
            } overlayView: {
                EmptyView()
            }
        }
        .onTapGesture {
            onTabChanged()
        }
    }
}

struct VideoCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            VideoCardView<CardData>(data: CardData(
                imageURL: "https://placehold.co/358x200/png",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "22:22"
            ), onTabChanged: {
                debugPrint("22:22")
            })
        }
    }
}
