//
// CardViewGallery.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import MobileDesign
struct CardViewGallery: View {
    var datas: [CardData] = {
        return stride(from: 0, to: 100, by: 1).map { _ in
            CardData(
                imageURL: "https://placehold.co/358x200/png",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "22:22"
            )
        }
    }()
    var body: some View {
        List {
            ForEach(datas) { data in
                VideoCardView(data: data)
            }
        }.listRowSeparator(.hidden)
            .listStyle(.plain)
    }

}

struct CardViewGallery_Previews: PreviewProvider {
    static var previews: some View {
        CardViewGallery()
    }
}
