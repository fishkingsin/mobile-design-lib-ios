//
// ColorItem.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct ColorItem: View {
    var key: String
    var color: UIColor?
    let fonts = ThemeManager.shared.currentTheme.fonts
    public var body: some View {
        if let c = color?.color, let rgb = color?.getRGBIntString(), let hex = color?.hexString {
            HStack(alignment: .center, spacing: 4) {
                VStack {
                    Text("\(key)")
                        .font(fonts.eleRegular12.uiFont)
                    Rectangle()
                        .fill(c)
                        .frame(width: 50, height: 50)
                        .padding(5)
                        .border(Color.secondary, width: 5)

                    Text("\(rgb)")
                        .font(fonts.eleRegular12.uiFont)
                    Text("\(hex)")
                        .font(fonts.eleRegular12.uiFont)
                }
            }.aspectRatio(1.0, contentMode: .fill)
        }
    }
}

struct ColorItem_Previews: PreviewProvider {
    static var previews: some View {
        ColorItem(key: "Red", color: .red)
    }
}
