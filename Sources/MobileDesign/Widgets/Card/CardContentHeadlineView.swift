//
// CardContentHeadlineView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct CardContentHeadlineView: View {
    var headline: String
    var lineLimit: Int?
    var body: some View {
        Text(headline)
            .lineLimit(lineLimit ?? 2)
            .font(ThemeManager.shared.currentTheme.fonts.eleMedium14.uiFont)
            .foregroundColor(ThemeManager.shared.currentTheme.colors.headline.color)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CardContentTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentHeadlineView(headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式").padding(16)
    }
}
