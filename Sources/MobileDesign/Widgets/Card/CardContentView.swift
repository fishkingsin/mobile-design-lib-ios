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
    public var cardContentType: CardContentType
    
    public init(headline: String,
                leadingFootnote: String,
                secondFootnote: String,
                cardContentType: CardContentType) {
        self.headline = headline
        self.leadingFootnote = leadingFootnote
        self.secondFootnote = secondFootnote
        self.cardContentType = cardContentType
    }
    public var body: some View {
        VStack(spacing: 4) {
            CardContentHeadlineView(headline: headline, cardContentType: cardContentType)
            CardContentFootnoteView(leadingFootnote: leadingFootnote, secondFootnote: secondFootnote)
        }
    }
}
public enum CardContentType {
    case TVVideoPlayer
    case other
    
    var font: Font {
        switch self {
        case .TVVideoPlayer:
            return ThemeManager.shared.currentTheme.fonts.articleH1.uiFont
        default:
            return ThemeManager.shared.currentTheme.fonts.eleRegular16.uiFont
        }
    }
}

struct CardContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentView(
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點",
            cardContentType: .other
        )
    }
}
