//
// ReelCard.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct ReelCard<Data>: View where Data: CardDisplayable & TimecodeDisplayable {
    var data: Data
    var viewDidClick: () -> Void

    public init(data: Data,
                viewDidClick: @escaping () -> Void) {
        self.data = data
        self.viewDidClick = viewDidClick
    }

    public var body: some View {
        Button(action: {
            viewDidClick()
        }) {
            TopImageCardView(imageUrl: data.imageURL, imageWidth: 124, imageHeight: 224) {
                Rectangle()
                    .frame(maxWidth: 124, maxHeight: 224)
                    .cornerRadius(4)
            } contentView: {
                Text("")
            } overlayView: {
                CardTimecodeOverlayView(timecode: data.timecode)
                    .padding(4)
            }.frame(minWidth: 124, minHeight: 224)
        }
    }
}

struct ReelCard_Previews: PreviewProvider {
    static var previews: some View {
        ReelCard(data: CardData(
            imageURL: "https://placehold.co/124x224/png",
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點",
            timecode: "22:22"
        ), viewDidClick: {
            debugPrint("click reel 1")
        })
    }
}
