//
// Chip.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import SwiftUI

public struct Chip<Element>: View where Element: ChipData {
  private let theme: NMGThemeable = ThemeManager.shared.currentTheme
  let element: Element
  @Binding var index: Int
  let selfIndex: Int
  let font: Font

  public init(
    element: Element, index: Binding<Int>, selfIndex: Int,
    font: Font = Font(ThemeManager.shared.currentTheme.fonts.headline)
  ) {
    self.element = element
    self._index = index
    self.selfIndex = selfIndex
    self.font = font
  }

  public var body: some View {
    HStack(alignment: .top, spacing: 8) {
      Text(element.title)
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

private struct ChipElement: ChipData {
  var id: String = UUID().uuidString

  var title: String

  init(title: String) {
    self.title = title
  }
}

struct Chip_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      Chip(element: ChipElement(title: "Title"), index: .constant(1), selfIndex: 0)
      Chip(element: ChipElement(title: "Title"), index: .constant(1), selfIndex: 1)
    }
  }
}
