//
// CardContentView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct CardContentView: View {
    var headline: String
    var leadingFootnote: String
    var secondFootnote: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CardContentHeadlineView(headline: headline)
            CardContentFootnoteView(leadingFootnote: leadingFootnote, secondFootnote: secondFootnote)
        }
        .frame(alignment: .topLeading)
    }
}

struct CardContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentView(
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點"
        )
    }
}
