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
                    .font(ThemeManager.shared.currentTheme.fonts.eleRegular16.uiFont)
                    .kerning(0.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
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

        HStack {
            HorizontalCardView(imageUrl: data.imageURL, overLayViewAlign: .bottomTrailing) {
                Image(ImageResource.placeholder)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 133, alignment: .topLeading)
                    .aspectRatio( 133 / 75 , contentMode: .fit)
                    .clipped()
                    .cornerRadius(4)
            } contentView: {
                CardContentHeadlineView(headline: data.headline, lineLimit: 3)
            } overlayView: {
                content()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }


    }
}

struct HorizontalCard_Previews: PreviewProvider {
    static var previews: some View {
        List(stride(from: 10, to: 50, by: 1).map { i in
            CardData(
                imageURL: ( i % 2 == 0 ) ? "" : "https://placehold.co/358x200/png?text=\(i)",
                headline: String.random(length: i)!,
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點"
            )
        }) { data in

            HorizontalCard(data: data) {
                ZStack {
                    Rectangle()
                        .opacity(0.3)
                        .foregroundStyle(.black)
                    Text("正在播放").foregroundStyle(.white)
                }
            }

            .listRowSeparator(.hidden)
            .background( data.imageURL.contains("13") ? .black.opacity(0.1) : .clear)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listRowInsets(.none)
        .listStyle(.plain)
    }
}


extension String {
    fileprivate static func shuffeld(length: Int, alphabet:String = "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式獨家專訪｜用科技顛覆金融 李小加革新小店投資模式") -> String? {
        guard
            alphabet.count > 0
                && length > 0
        else { return nil }
        return alphabet.shuffled().prefix(length).map {String($0)}.joined()
    }
}

extension String {
    fileprivate static func random(length: Int, alphabet:String = "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式獨家專訪｜用科技顛覆金融 李小加革新小店投資模式") -> String? {
        let a = (0..<length).reduce("") { partialResult, _ in
            partialResult + alphabet
        }
        return shuffeld(length: length, alphabet: a)
    }
}
