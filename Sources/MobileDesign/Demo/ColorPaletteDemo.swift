//
// ColorPaletteDemo.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import SwiftUI

public struct ColorPaletteDemo: View {
    let colors: [any NMGThemeableColors] = [
        WWColors(),
        MOREColors(),
        EDColors(),
        KISSColors(),
        GOTRIPColors(),
        OSColors(),
        NMColors(),
        OHColors()
    ]

    public init() {}

    public var body: some View {
        // Vertical ScrollView for the Grid layout
        ScrollView {
            if #available(iOS 14.0, *) {
                VStack {
                    ForEach(colors, id: \.self.hashValue) { color in
                        Text("\(String(describing: color.self))")
                        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50)), count: 3)) {
                            ForEach(color.properties().keys.sorted { a, b in
                                a < b
                            }, id: \.self) { key in
                                ColorItem(key: key, color: color.properties()[key])
                            }
                        }.padding()
                    }
                    Spacer(minLength: 10)
                    Text("Common")
                    LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50)), count: 3)) {
                        ForEach(EDColors().common().keys.sorted { a, b in
                            a < b
                        }, id: \.self) { key in
                            ColorItem(key: key, color: EDColors().common()[key])
                                .padding([.bottom], 10)
                        }
                    }.padding()
                }

            } else {
                // Fallback on earlier versions
            }

        }.padding()
    }
}

struct ColorPaletteDemo_Previews: PreviewProvider {
    static var previews: some View {
        ColorPaletteDemo()
    }
}
