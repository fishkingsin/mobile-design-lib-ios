//
//  PlaylistItem.swift
//  
//
//  Created by Felix Fok Ka Chun on 10/10/2023.
//

import SwiftUI

public struct PlaylistItem<Data>: View where Data: CardDisplayable & TimecodeDisplayable {
    var data: Data
    public init(data: Data) {
        self.data = data
    }
    public var body: some View {
        VStack {
            TopImageCardView(imageUrl: data.imageURL, imageWidth: UIScreen.main.bounds.width - 32,
                             imageHeight: 9.0/16.0 * (UIScreen.main.bounds.width - 32), alignment: .center) {
                // MARK: update placeholder
                Rectangle()
                    .fill(.gray)
                    .frame(height: 200)
            } contentView: {
                CardContentView(
                    headline: data.headline,
                    leadingFootnote: data.leadingFootnote,
                    secondFootnote: data.secondFootnote
                ).padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            } overlayView: {
                Image(systemName: "play.circle")
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .foregroundColor(.white)
            }
            .padding(12)
            Rectangle()
                .fill(ThemeManager.shared.currentTheme.colors.neutralGray5.color)
                .frame(height: 2)
        }
    }
}

struct PlaylistItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            PlaylistItem<CardData>(data: CardData(
                imageURL: "https://placehold.co/358x200/png",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "00:00"
            ))
        }
    }
}

