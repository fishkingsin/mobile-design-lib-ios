//
// LazyVerticalGrid.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct LazyVerticalGrid<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let fonts = ThemeManager.shared.currentTheme.fonts
    let colors = ThemeManager.shared.currentTheme.colors
    var columns: [GridItem]
    var data: Data
    var horizontalAlignment: HorizontalAlignment
    let content: (Int, Data.Element) -> Content

    public init(columns: [GridItem], data: Data, horizontalAlignment: HorizontalAlignment = .leading, content: @escaping (Int, Data.Element) -> Content) {
        self.columns = columns
        self.data = data
        self.content = content
        self.horizontalAlignment = horizontalAlignment
    }

    public var body: some View {
        LazyVGrid(columns: columns, alignment: horizontalAlignment) {
            ForEach(Array(data.enumerated()), id: \.offset) { index, element in
                content(index, element)

            }
        }
    }

    var elements: [Data.Element] {
        data.map { $0 }
    }
}
struct LazyVerticalGrid_Previews: PreviewProvider {
    static var previews: some View {

        let data = [
            "", "56,364.19萬", "56,364.19萬", "56,364.19萬", "56,364.19萬", "56,364.19萬",
            "", "11%", "131.34%", "31.34%", "31.34%", "31.34%"
        ]
        if #available(iOS 14.0, *) {
            LazyVerticalGrid(
                columns:
                    [
                        GridItem(.fixed(10)),
                        GridItem(.flexible(minimum: 30)),
                        GridItem(.flexible(minimum: 30)),
                        GridItem(.flexible(minimum: 30)),
                        GridItem(.flexible(minimum: 30)),
                        GridItem(.flexible(minimum: 30))
                    ],
                data: data) { _, element in
                Text(element).font(.caption2)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct LazyVerticalGrid_OneRow_Previews: PreviewProvider {
    static var previews: some View {

        let data = [
            "2022/Q1",
            "2022/Q2",
            "2022/Q3",
            "2022/Q4",
            "2022/FY"
        ]
        if #available(iOS 14.0, *) {
            HStack(alignment: .center) {
                LazyVerticalGrid(
                    columns:
                        stride(from: 0, to: data.count, by: 1)
                        .map { _ in
                            GridItem(.fixed(60))
                        },
                    data: data,
                    horizontalAlignment: .center
                ) { _, element in
                    ZStack {
                        Color.red
                        Text(element).font(.caption2)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
