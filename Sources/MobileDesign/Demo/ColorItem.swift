//
// ColorItem.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import SwiftUI

public struct ColorItem: View {
    var key: String
    var color: UIColor?
    public var body: some View {
        if let c = color?.color, let rgb = color?.getRGBIntString(), let hex = color?.hexString {
            HStack(alignment: .center, spacing: 4) {
                VStack {
                    Text("\(key)")
                        .font(.footnote)
                    Rectangle()
                        .fill(c)
                        .frame(width: 50, height: 50)
                        .shadow(color: Color.secondary, radius: 8)

                    Text("\(rgb)")
                        .font(.footnote)
                    Text("\(hex)")
                        .font(.footnote)
                }
            }.aspectRatio(1.0, contentMode: .fill)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ColorItem(key: "Red", color: .red)
    }
}
