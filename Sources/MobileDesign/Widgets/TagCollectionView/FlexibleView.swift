//
// FlexibleView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

// reference: https://www.fivestars.blog/articles/flexible-swiftui/
public struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {

  let data: Data
  let alignment: HorizontalAlignment
  let inLineSpacing: CGFloat
  let spacing: CGFloat
  let content: (Data.Element) -> Content
  @State private var availableWidth: CGFloat = 0
  @State private var elementsSize: [Data.Element: CGSize] = [:]

  public init(
    data: Data,
    alignment: HorizontalAlignment,
    inLineSpacing: CGFloat,
    spacing: CGFloat,
    content: @escaping (Data.Element) -> Content,
    availableWidth: CGFloat = 0,
    elementsSize: [Data.Element: CGSize] = [:]
  ) {
    self.data = data
    self.alignment = alignment
    self.inLineSpacing = inLineSpacing
    self.spacing = spacing
    self.content = content
    self.availableWidth = availableWidth
    self.elementsSize = elementsSize
  }

  public var body: some View {
    ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
      Color.clear
        .frame(height: 1)
        .readSize { size in
          availableWidth = size.width
        }

      VStack(alignment: alignment, spacing: inLineSpacing) {
        ForEach(computeRows(data, availableWidth, elementsSize, spacing), id: \.self) {
          rowElements in
          HStack(spacing: spacing) {
            ForEach(rowElements, id: \.self) { element in
              content(element)
                .fixedSize()
                .readSize { size in
                  elementsSize[element] = size
                }
            }
          }
        }
      }
    }
  }

  private func computeRows(
    _ data: Data, _ availableWidth: CGFloat, _ elementsSize: [Data.Element: CGSize],
    _ spacing: CGFloat
  ) -> [[Data.Element]] {

    data.reduce(([[Data.Element]()], availableWidth)) { partialResult, element in

      var rows = partialResult.0
      var remainingWidth = partialResult.1

      let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

      if remainingWidth - (elementSize.width + spacing) >= 0 {
        rows[rows.count - 1].append(element)
      } else {
        rows.append([element])
        remainingWidth = availableWidth
      }

        // swiftlint:disable:next shorthand_operator
      remainingWidth = remainingWidth - (elementSize.width + spacing)

      return (rows, remainingWidth)
    }.0
  }
}

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

// swiftlint:disable:next type_name
struct FlexibleView_Preview: PreviewProvider {

  static var previews: some View {
    let theme: NMGThemeable = ThemeManager.shared.currentTheme
    ScrollView {
      VStack {
        FlexibleView(
          data: (0...50).map { "card\($0)" }, alignment: .center, inLineSpacing: 8, spacing: 8,
          content: { item in
            TagView(
              value: item,
              modifier: TagViewModifier(
                foregroundColor: theme.colors.white.color,
                backgroundColor: theme.colors.primaryMain.color
              ),
              action: { _ in

              }
            )
            .clipShape(Capsule())
          })
      }

      VStack {
        FlexibleView(
          data: (0...50).map { "card\($0)" }, alignment: .center, inLineSpacing: 8, spacing: 8,
          content: { item in
            TagView(
              value: item,
              modifier: TagViewModifier(
                foregroundColor: theme.colors.neutralGray10.color,
                backgroundColor: theme.colors.primaryMain.color
              ),
              action: { _ in

              }
            )
            .clipShape(Capsule())
          })
      }
    }
  }
}
