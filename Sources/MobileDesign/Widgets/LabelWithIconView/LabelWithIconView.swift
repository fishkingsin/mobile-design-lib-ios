//
// LabelWithIconView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct LabelWithIconViewModifier: ViewModifier {
    
    var tintColor: Color
    var font: Font
    
    public init(tintColor: Color, font: Font) {
        self.tintColor = tintColor
        self.font = font
    }
    
    public func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(tintColor)
    }
}

public struct LabelWithIconView: View {
    let theme = ThemeManager.shared.currentTheme
    let title: String
    var modifier: LabelWithIconViewModifier
    let icon: UIImage
    let aciont: () -> Void

    public init(
        title: String,
        modifier: LabelWithIconViewModifier? = nil,
        icon: UIImage,
        aciont: @escaping () -> Void)
    {
        self.title = title
        self.modifier = modifier ?? LabelWithIconViewModifier(
            tintColor: theme.colors.neutralGray10.color,
            font: theme.fonts.caption.uiFont
        )
        self.icon = icon
        self.aciont = aciont
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 3) {
            Spacer(minLength: 0)
            Text(title).modifier(modifier)
            Image(uiImage: icon).foregroundColor(modifier.tintColor)
        }.onTapGesture {
            aciont()
        }
    }
}

struct LabelWithIconView_Previews: PreviewProvider {
    static var previews: some View {
        LabelWithIconView(title: "All", icon: ThemeManager.shared.currentTheme.icons.warnning) {

        }
    }
}
