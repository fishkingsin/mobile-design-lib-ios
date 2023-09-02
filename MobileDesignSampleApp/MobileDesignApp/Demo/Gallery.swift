//
// Gallery.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import MobileDesign
struct Gallery: View {
    var data = [
        MenuItem<ColorPaletteDemo>(name: "Color", content:  { ColorPaletteDemo()
        })
    ]
    var body: some View {
        NavigationView(content: {
            List {
                ForEach(data) { item in
                NavigationLink(
                    destination: item.content,
                    label: {
                        Text(item.name)
                    })

                }
            }
        }).navigationTitle("NMG MDL")
    }
}

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
    }
}
