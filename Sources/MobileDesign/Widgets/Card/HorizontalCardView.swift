//
//  HorizontalCardView.swift
//
//
//  Created by Felix Fok Ka Chun on 19/9/2023.
//

import SwiftUI
import Kingfisher

struct HorizontalCardView<PlaceholderView: View, ContentView: View, OverlayView: View>: View {
    let imageUrl: String
    let overLayViewAlign: Alignment
    let placeholderView: PlaceholderView
    let contentView: ContentView
    let overlayView: OverlayView


    public init(
        imageUrl: String,
        overLayViewAlign: Alignment,
        @ViewBuilder placeholderView: @escaping () -> PlaceholderView,
        @ViewBuilder contentView: @escaping () -> ContentView,
        @ViewBuilder overlayView: @escaping () -> OverlayView
    ) {
        self.imageUrl = imageUrl
        self.overLayViewAlign = overLayViewAlign
        self.placeholderView = placeholderView()
        self.contentView = contentView()
        self.overlayView = overlayView()
    }

    public var body: some View {
        HStack {
                if let url = URL(string: imageUrl) {
                    KFImage(url)
                        .placeholder({ _ in
                            getPlaceholder()
                        })
                        .resizable()
                        .aspectRatio( 133 / 75, contentMode: .fit)
                        .frame(maxWidth: 133)
                        .clipped()
                        .cornerRadius(4)
                        .overlay(alignment: overLayViewAlign) {
                            overlayView
                                .cornerRadius(4)
                        }
                } else {
                    getPlaceholder().overlay {
                        overlayView
                            .cornerRadius(4)
                    }
                }
            VStack {
                contentView

                Spacer()
            }.frame(maxHeight: 75)
            Spacer()
        }

    }

    private func getPlaceholder() -> some View {
        placeholderView
            .aspectRatio( 133 / 75, contentMode: .fit)
            .frame(maxWidth: 133)
            .clipped()
            .cornerRadius(4)
    }
}

#Preview("HorizontalCardView_Previews") {
    HorizontalCardView(imageUrl: "https://placehold.co/133x75/png",
                       overLayViewAlign: .center) {
        Rectangle()
            .foregroundColor(.red)
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 75)
            .clipped()
            .cornerRadius(4)
    } contentView: {
         Text("HKTVmall 2.0 ？拆解友和申請上市之謎 一年收入5億 ？｜抽新股｜IPO｜ 日本城｜ 港股｜王維基【經一解密】 經濟一週 EDigest")
    } overlayView: {
        ZStack {
            Rectangle()
                .opacity(0.3)
                .foregroundStyle(.black)
            Text("正在播放").foregroundStyle(.white)
        }
    }.background(.red)
}

#Preview("HorizontalCardView_Previews_2") {
    List {
        ForEach(1...100, id: \.self) { i in
            HorizontalCardView(imageUrl: "",
                               overLayViewAlign: .center) {
                Rectangle()
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 133, maxHeight: 75)
                    .clipped()
                    .cornerRadius(4)
            } contentView: {
                Text("HKTVmall 2.0 ？拆解友和申請上市之謎 一年收入5億 ？｜抽新股｜IPO｜ 日本城｜ 港股｜王維基【經一解密】 經濟一週 EDigest")
            } overlayView: {
                ZStack {
                    Rectangle()
                        .opacity(0.3)
                        .foregroundStyle(.black)
                    Text("正在播放").foregroundStyle(.white)
                }
            }.background(.red)
        }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    .listRowInsets(.none)
    .listStyle(.plain)
}
