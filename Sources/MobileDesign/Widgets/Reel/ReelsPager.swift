//
// ReelsPager.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import AVKit
import SwiftUIIntrospect


public struct ReelPager<Data>: View where Data: ReelDataProtocol {

    public init () {}

    let colors: [Color] = [
        .red, .green, .blue, .gray
    ]


    public var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(colors, id: \.self) { color in
                    color.onAppear {
                        print("\(color) Appear")
                    }.onDisappear{
                        print("\(color) Disppear")
                    }
                }
                .rotationEffect(.degrees(-90)) // Rotate content
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height
                )
            }
            .frame(
                width: proxy.size.height, // Height & width swap
                height: proxy.size.width
            )
            .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
            .offset(x: proxy.size.width) // Offset back into screens bounds
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never)
            )
        }
    }
}

struct ReelPager_Previews: PreviewProvider {
    static var previews: some View {
        ReelPager<Reel<MediaFile>>()
//        ReelPager<Reel<MediaFile>>(reels: MediaFileJSON.map { item -> Reel in
//
//            let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
//
//            let player = AVPlayer(url:  URL(string: "https://www.pexels.com/download/video/5913482/")!)
//
//            return Reel(player: player, title: item.title, mediaFile: item)
//        })
    }
}
