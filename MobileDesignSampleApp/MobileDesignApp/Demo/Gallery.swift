//
// Gallery.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import MobileDesign
import AVKit
struct Gallery: View {
    var data = [
        MenuItem(
            name: "Colors",
            content: {
                AnyView(ColorPaletteDemo())
            }),
        MenuItem(
            name: "Fonts",
            content: {
                AnyView(FontsDemo())
            }),
        MenuItem(
            name: "CardView",
            content: {
                AnyView(CardViewGallery())
            }
        ),
        MenuItem(
            name: "ChipGroup",
            content: {
                AnyView(ChipGroupDemo(index: 0))
            }
        ),
        MenuItem(
            name: "ReelPager",
            content: {
                AnyView(ReelsPager(currentReel: reels.first!.id, reels: reels))

            }
        )
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
            .navigationBarTitle("NMG Mobile Design Library 🏛️", displayMode: .inline)
            .navigationBarTitleDisplayMode(.inline)
        })
    }
}

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery().environmentObject(ThemeManager.shared)
    }
}
