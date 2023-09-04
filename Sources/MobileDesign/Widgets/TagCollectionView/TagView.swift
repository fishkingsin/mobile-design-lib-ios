//
// TagView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct TagViewModifier: ViewModifier {
    var backgroundColor: Color
    var foregroundColor: Color
    public init(foregroundColor: Color, backgroundColor: Color) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    public func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
    }
}

public struct TagView: View {
    
    let value: String
    
    private let theme: NMGThemeable
    
    var modifier: TagViewModifier
    
    let action: (String) -> Void
    public init(
        value: String,
        theme: NMGThemeable = ThemeManager.shared.currentTheme,
        modifier: TagViewModifier? = nil,
        action: @escaping (String) -> Void
    ) {
        self.value = value
        self.theme = theme
        self.modifier = modifier != nil ?
        modifier! :
        TagViewModifier(
            foregroundColor: Color(theme.colors.neutralGray10),
            backgroundColor: Color(theme.colors.primaryMain)
        )
        self.action = action
    }
    
    public var body: some View {
        Text(value)
            .font(Font(theme.fonts.caption as CTFont))
            .lineLimit(1)
            .padding([.leading, .trailing], 8)
            .padding([.top, .bottom], 4)
            .modifier(modifier)
            .onTapGesture {
                action(value)
            }
    }
}
