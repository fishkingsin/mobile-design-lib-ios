//
//  HorizontalCardContent.swift
//  
//
//  Created by Felix Fok Ka Chun on 19/9/2023.
//

import SwiftUI

struct HorizontalCardContent: View {
    var headline: String
    var leadingFootnote: String?
    var secondFootnote: String?
    var body: some View {
        CardContentHeadlineView(headline: headline, lineLimit: 3)
    }
}

struct HorizontalCardContent_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCardContent(
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點"
        )
    }
}
