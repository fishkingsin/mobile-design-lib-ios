//
//  HorizontalCard.swift
//  
//
//  Created by Felix Fok Ka Chun on 19/9/2023.
//

import SwiftUI

public struct HorizontalCard<Data>: View where Data: CardDisplayable & TimecodeDisplayable {
    
    var data: Data
    var OLVAlign: Alignment
    
    public init(data: Data) {
        self.data = data
        OLVAlign = .bottomTrailing
    }
    
    public var body: some View {
        VStack{
            HStack {
                HorizontalCardView(imageUrl: data.imageURL, overLayViewAlign: OLVAlign) {
                    Rectangle().fill(.gray).frame(width: 133, height: 75)
                } contentView: {
                    CardContentHeadlineView(headline:  data.headline, lineLimit: 3)
                } overlayView: {
                    CardTimecodeOverlayView(timecode: data.timecode).padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 4))
                }
            }
            .padding(12)
            Rectangle()
                .fill(ThemeManager.shared.currentTheme.colors.neutralGray5.color)
                .frame(height: 2)
        }
    }    
}

struct HorizontalCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
//            Color.red
            HorizontalCard<CardData>(data: CardData(
                imageURL: "",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "22:22"
            ))
        }
    }
}
