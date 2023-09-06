//
// ReelsPager.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import AVKit
//import SwiftUIIntrospect

public struct ReelPager<Data>: View where Data: ReelDataProtocol {


    public var body: some View {
        ZStack {
            Color.red
        }
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach([Color.red, Color.green, Color.blue], id: \.self) { color in
                        Rectangle()
                            .fill(Color.yellow)
//                        color.frame(proxy.size)
                    }
                }
            }
//            .introspect(.scrollView, on: .iOS(.v15, .v16, .v17)) { sv in
//                sv.isPagingEnabled = true
//            }
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
