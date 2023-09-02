//
// CardContentHeadlineView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct CardContentHeadlineView: View {
    var headline: String
    var body: some View {
        Text(headline)
            .lineLimit(2)
            .font(ThemeManager.shared.currentTheme.fonts.headline.uiFont)
            .foregroundColor(ThemeManager.shared.currentTheme.colors.headline.color)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .topLeading)
    }
}

struct CardContentTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentHeadlineView(headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式").padding(16)
    }
}
