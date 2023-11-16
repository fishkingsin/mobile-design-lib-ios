//
// Chip.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import SwiftUI
import Kingfisher

public struct Chip<Element>: View where Element: ChipData {
    private let theme: NMGThemeable = ThemeManager.shared.currentTheme
    let element: Element
    @Binding var index: Int
    let selfIndex: Int
    let font: Font
    
    public init(
        element: Element, index: Binding<Int>, selfIndex: Int,
        font: Font = Font(ThemeManager.shared.currentTheme.fonts.eleRegular16)
    ) {
        self.element = element
        self._index = index
        self.selfIndex = selfIndex
        self.font = font
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if let iconString = element.icon, let iconUrl = URL(string: iconString) {
                KFImage(iconUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            Text(element.name ?? "")
                .foregroundColor(
                    isSelected
                    ? Color(theme.colors.chipSelectedForeground) : Color(theme.colors.chipForeground)
                )
                .font(font)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            isSelected ? Color(theme.colors.chipSelectedBackground) : Color(theme.colors.chipBackground)
        )
        .cornerRadius(60)
    }
    
    var isSelected: Bool {
        selfIndex == index
    }
}

public struct ChipElement: ChipData {
    public var id: Int?
    public var name: String?
    public var icon: String?
    
    public init(id: Int? = nil, name: String? = nil, icon: String? = nil) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}

struct Chip_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Chip(element: ChipElement(name: "Title"), index: .constant(1), selfIndex: 0)
            Chip(element: ChipElement(name: "Title"), index: .constant(1), selfIndex: 1)
        }
    }
}
