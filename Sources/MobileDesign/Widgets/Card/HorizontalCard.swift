//
//  HorizontalCard.swift
//
//
//  Created by Felix Fok Ka Chun on 19/9/2023.
//

import SwiftUI
public struct CardOverlayView: View {
    var title: String
    public init(title: String) {
        self.title = title
    }
    public var body: some View {
        Group {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 133, height: 75)
                    .background(.black.opacity(0.75))
                    .cornerRadius(4)
                Text(title)
                // - TODO: felix fix it use theme font
                    .font(Font.custom("PingFang HK", size: 16))
                    .kerning(0.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
        //        .background( isPlaying ? Color(red: 0.95, green: 0.95, blue: 0.95) : Color.clear)

    }
}
public struct HorizontalCard<Data, Content>: View where Data: CardDisplayable, Content: View {

    var data: Data
    let content: () -> Content


    public init(data: Data, @ViewBuilder content: @escaping () -> Content) {
        self.data = data
        self.content = content
    }
    
    public var body: some View {
        VStack{
            HStack {
                HorizontalCardView(imageUrl: data.imageURL, overLayViewAlign: .bottomTrailing) {
                    Rectangle().fill(.gray).frame(width: 133, height: 75)
                } contentView: {
                    CardContentHeadlineView(headline:  data.headline, lineLimit: 3)
                } overlayView: {
                    content()
                }
            }
            .padding(12)
            Rectangle()
                .fill(ThemeManager.shared.currentTheme.colors.neutralGray5.color)
                .frame(height: 2)
        }
        // - TODO: felix fix it use theme color
//        .background( isPlaying ? Color(red: 0.95, green: 0.95, blue: 0.95) : Color.clear)
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
