//
// CardContentView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct CardContentView: View {
    public var headline: String
    public var leadingFootnote: String
    public var secondFootnote: String
    public init(headline: String, leadingFootnote: String, secondFootnote: String) {
        self.headline = headline
        self.leadingFootnote = leadingFootnote
        self.secondFootnote = secondFootnote
    }
    public var body: some View {
        VStack(spacing: 4) {
            CardContentHeadlineView(headline: headline)
            CardContentFootnoteView(leadingFootnote: leadingFootnote, secondFootnote: secondFootnote)
        }
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
