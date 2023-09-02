//
// Gallery.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import MobileDesign
struct Gallery: View {
    var data = [
        MenuItem(
            name: "Colors",
            content:  { AnyView(ColorPaletteDemo())
            }),
        MenuItem(
            name: "Fonts",
            content:  { AnyView(FontsDemo())
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("NMG Mobile Design Library 🏛️")
                }
            }
        })
    }
}

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
    }
}
