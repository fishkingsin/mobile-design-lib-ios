//
// VideoCardView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct VideoCardView<Data>: View where Data: CardDisplayable & TimecodeDisplayable {
    var data: Data
    var onTabChanged: () -> Void
    
    public init(data: Data, onTabChanged: @escaping () -> Void) {
        self.data = data
        self.onTabChanged = onTabChanged
    }
    public var body: some View {
        Button(action: {
            onTabChanged()
        }) {VStack {
            TopImageCardView(imageUrl: data.imageURL, imageWidth: nil, imageHeight: 200) {
                // MARK: update placeholder
                Rectangle()
                    .fill(.gray)

            } contentView: {
                CardContentView(
                    headline: data.headline,
                    leadingFootnote: data.leadingFootnote,
                    secondFootnote: data.secondFootnote
                ).padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            } overlayView: {
                CardTimecodeOverlayView(timecode: data.timecode).padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 4))
            }

            .padding(12)
            Rectangle()
                .fill(ThemeManager.shared.currentTheme.colors.neutralGray5.color)
                .frame(height: 2)
        }}

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
