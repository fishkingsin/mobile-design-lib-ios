//
//  HorizontalCard.swift
//
//
//  Created by Felix Fok Ka Chun on 19/9/2023.
//

import SwiftUI

public struct HorizontalCard<Data>: View where Data: CardDisplayable {
    
    var data: Data
    @Binding var isPlaying: Bool
    
    public init(data: Data, isPlaying: Binding<Bool>) {
        self.data = data
        self._isPlaying = isPlaying
    }
    
    public var body: some View {
        VStack{
            HStack {
                HorizontalCardView(imageUrl: data.imageURL, overLayViewAlign: .bottomTrailing) {
                    Rectangle().fill(.gray).frame(width: 133, height: 75)
                } contentView: {
                    CardContentHeadlineView(headline:  data.headline, lineLimit: 3)
                } overlayView: {
                    Group {
                        if isPlaying {
                            ZStack {
                                Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 133, height: 75)
                                .background(.black.opacity(0.75))
                                .cornerRadius(4)
                                Text("正在播放")
                                .font(Font.custom("PingFang HK", size: 16))
                                .kerning(0.4)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .padding(12)
            Rectangle()
                .fill(ThemeManager.shared.currentTheme.colors.neutralGray5.color)
                .frame(height: 2)
        }.background( isPlaying ? Color(red: 0.95, green: 0.95, blue: 0.95) : Color.clear)
    }
}

//struct HorizontalCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            HorizontalCard<CardData>(data: CardData(
//                imageURL: "",
//                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
//                leadingFootnote: "4小時前",
//                secondFootnote: "經人觀點"
//            ))
//        }
//    }
//}
