//
// ChartLegendGroupView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct TagModifier: ViewModifier {
    var foregroundColor: UIColor
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    public init(foregroundColor: UIColor, width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 2) {
        self.foregroundColor = foregroundColor
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    public func body(content: Content) -> some View {
        foregroundColor.color
            .cornerRadius(cornerRadius)
            .frame(width: width, height: height)
    }
}

public struct BarIndicator: View {
    var modifier: TagModifier
    public init(color: UIColor = ThemeManager.shared.currentTheme.colors.primaryMain) {
        self.modifier = TagModifier(
            foregroundColor: color,
            width: 8,
            height: 8
        )
    }
    public var body: some View {
        ZStack {
        }
        .modifier(modifier)
    }
}

public struct LineIndicator: View {
    var modifier: TagModifier

    public init(color: UIColor = ThemeManager.shared.currentTheme.colors.primaryMain) {
        self.modifier = TagModifier(
            foregroundColor: color,
            width: 8,
            height: 4
        )
    }
    public var body: some View {
        ZStack {
        }
        .modifier(modifier)
    }
}

public struct SimpleKeyValueData: Hashable {

    public var key: String
    public var value: String

    public init(_ key: String, _ value: String) {
        self.key = key
        self.value = value
    }

    public static func == (lhs: SimpleKeyValueData, rhs: SimpleKeyValueData) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}

public struct ChartHeading<Data: Collection, Content: View>: View where Data.Element: Hashable {

    let data: Data
    let content: (Data.Element) -> Content

    public init(data: Data, content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }

    public var body: some View {
        VStack {
            HStack {
                ForEach(elements, id: \.self) { element in
                    content(element)
                }
            }
        }
    }

    var elements: [Data.Element] {
        data.map { $0 }
    }
}

public struct ChartLegendGroupView: View {
    var element: SimpleKeyValueData
    let fonts = ThemeManager.shared.currentTheme.fonts
    public init(element: SimpleKeyValueData) {
        self.element = element
    }
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                BarIndicator()
                Text(element.key)
                    .fixedSize()
                    .font(fonts.eleRegular12.uiFont)
            }
            HStack {
                LineIndicator()
                Text(element.value)
                    .fixedSize()
                    .font(fonts.eleRegular12.uiFont)
            }
        }
    }
}

struct ChartLegendGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                LazyVerticalGrid(
                    columns: [GridItem(.adaptive(minimum: 50)),
                              GridItem(.adaptive(minimum: 50)),
                              GridItem(.adaptive(minimum: 50)),
                              GridItem(.adaptive(minimum: 50))],
                    data: [
                        SimpleKeyValueData("總收入", "按年增長"),
                        SimpleKeyValueData("毛利", "按年增長"),
                        SimpleKeyValueData("經營利潤", "按年增長"),
                        SimpleKeyValueData("淨利", "按年增長")
                    ]) { _, element in
                        ChartLegendGroupView(element: element)
                    }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
