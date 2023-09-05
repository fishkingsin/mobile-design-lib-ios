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
            content:  {
                AnyView(ColorPaletteDemo())
            }),
        MenuItem(
            name: "Fonts",
            content:  {
                AnyView(FontsDemo())
            }),
        MenuItem(
            name: "Tabbar",
            content: {
                AnyView(TabbarDemo(index: 0))
            }
        ),
        MenuItem(
            name: "CardView",
            content: {
                AnyView(CardViewGallery())
            }
        ),
        MenuItem(name: "ReelPager",
                 content: {
                     AnyView(
                        ReelPager<Reel<MediaFile>>(
                            reels: stride(from: 0, through: 3, by: 1)
                                .map {


                                return Reel(player: nil, title: "\($0)", mediaFile: MediaFile(url: "https://www.pexels.com/download/video/5913482/", title: "\($0)", isExpanded: true))

                            }))
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
            .navigationTitle("NMG Mobile Design Library 🏛️")
            .navigationBarTitleDisplayMode(.inline)
        })
    }
}

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
    }
}
