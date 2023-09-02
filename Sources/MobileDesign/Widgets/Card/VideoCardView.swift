//
// VideoCardView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct VideoCardView<Data>: View where Data: CardDisplayable & TimecodeDisplayable {
    var data: Data
    public init(data: Data) {
        self.data = data
    }
    public var body: some View {
        TopImageCardView(imageUrl: data.imageURL, imageWidth: nil, imageHeight: 200) {
            // MARK: update placeholder
            Rectangle()
                .frame(maxHeight: 200)
                
        } contentView: {
            CardContentView(
                headline: data.headline,
                leadingFootnote: data.leadingFootnote,
                secondFootnote: data.secondFootnote
            )
        } overlayView: {
            CardTimecodeOverlayView(timecode: data.timecode).padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 4))
        }

        .padding(16)
    }
}

struct VideoCardView_Previews: PreviewProvider {
    static var previews: some View {
        VideoCardView<CardData>(data: CardData(
            imageURL: "https://placehold.co/358x200/png",
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點",
            timecode: "22:22"
        ))
    }
}
