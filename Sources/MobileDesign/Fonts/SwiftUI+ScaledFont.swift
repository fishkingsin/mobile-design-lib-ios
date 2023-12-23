//
// SwiftUI+ScaledFont.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return modifier(ScaledFont(name: name, size: size))
    }
}

extension UIFont {
    public var uiFont: Font {
        let scaledSize = UIFontMetrics.default.scaledValue(for: pointSize)
        return Font(withSize(scaledSize))
    }
}
