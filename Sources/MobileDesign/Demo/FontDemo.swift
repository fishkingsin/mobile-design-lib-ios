//
// FontDemo.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct FontItem: View {
    var key: String
    var font: Font
    var size: CGFloat
    public var body: some View {
        HStack(spacing: 10) {
            Text(String(format: "%.f", size)).font(.body)

            Text(key).font(font)
        }
    }
}

public struct FontsDemo: View {
    let fonts = NMGDefaultFonts()

    var sortedKeys: [String] {
        Array(fonts.properties).sorted { a, b in
            a.value.pointSize > b.value.pointSize
        }.map { $0.key }
    }

    private var grid = [GridItem(.flexible())]

    public init() {

    }

    public var body: some View {
        NavigationView {

            // Vertical ScrollView for the Grid layout
            ScrollView {

                // Custom Grid View
                LazyVGrid(columns: grid, spacing: 20) {
                    ForEach(sortedKeys, id: \.self) {

                        FontItem(
                            key: $0,
                            font: fonts.properties[$0]!.uiFont,
                            size: fonts.properties[$0]!.pointSize
                            )
                    }
                    .padding()
                    .shadow(radius: 13)

                }
                .frame(width: .infinity)
                .padding()
            }

            .navigationBarTitle("Fonts")
        }
    }
}

struct FontsDemo_Previews: PreviewProvider {
    static var previews: some View {
        FontsDemo()
    }
}
