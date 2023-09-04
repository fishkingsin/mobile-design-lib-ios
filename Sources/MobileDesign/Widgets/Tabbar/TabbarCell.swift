//
// TabbarCell.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import SwiftUI

public struct TabbarCell: View {
    private let theme: NMGThemeable = ThemeManager.shared.currentTheme
    let element: String
    @Binding var index: Int
    let selfIndex: Int
    let font: Font

    public init(element: String, index: Binding<Int>, selfIndex: Int, font: Font = Font(ThemeManager.shared.currentTheme.fonts.headline)) {
        self.element = element
        self._index = index
        self.selfIndex = selfIndex
        self.font = font
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(element)
                .foregroundColor(
                    isSelected ? Color(theme.colors.tabSelectedForegroud) : Color(theme.colors.tabForegroud))
                .font(font)
        }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                isSelected ? Color(theme.colors.tabSelectedBackgroud) : Color(theme.colors.tabBackgroud)
            )
            .cornerRadius(60)
    }

    var isSelected: Bool {
        selfIndex == index
    }
}


struct TabbarCell_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TabbarCell(element: "Title", index: .constant(1), selfIndex: 0)
            TabbarCell(element: "Title", index: .constant(1), selfIndex: 1)
        }
    }
}

