//
// CardContentFootnoteView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct CardContentFootnoteView: View {
    let font = ThemeManager.shared.currentTheme.fonts.eleRegular14.uiFont
    let foregroundColor = ThemeManager.shared.currentTheme.colors.footnote.color
    var leadingFootnote: String
    var secondFootnote: String
    var body: some View {
        HStack(spacing: 8) {
            Text(leadingFootnote)
                .font(font)
                .foregroundColor(foregroundColor)
            Text(secondFootnote)
                .font(font)
                .foregroundColor(foregroundColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CardContentFootnoteView_Previews: PreviewProvider {
    static var previews: some View {
        CardContentFootnoteView(leadingFootnote: "4小時前", secondFootnote: "經人觀點")
    }
}
