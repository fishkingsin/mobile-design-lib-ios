//
// ReelsPager.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import AVKit
import SwiftUIPager

public struct ReelPager<Data>: View where Data: ReelDataProtocol {
    @StateObject var page1: Page = .first()
    @State var reels: [Data]
    @State var playerViewModel: PlayerViewModel

    public init(reels: [Data]) {
        self.reels = reels
        self.playerViewModel = PlayerViewModel()
    }

    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                Pager(page: self.page1,
                      data: self.reels,
                      id: \.self) {
                    CustomPlayerView(url: URL(string: $0.mediaFile.url)!)
                        .environmentObject(playerViewModel)
                }
                      .vertical()
                      .alignment(.start)
                      .itemSpacing(10)
            }
        }
    }
}

struct ReelPager_Previews: PreviewProvider {
    static var previews: some View {
        ReelPager<Reel<MediaFile>>(reels: MediaFileJSON.map { item -> Reel in

            let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""

            let player = AVPlayer(url:  URL(string: "https://www.pexels.com/download/video/5913482/")!)

            return Reel(player: player, title: item.title, mediaFile: item)
        })
    }
}
