//
// ReelsPager.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import PageView
import AVKit


public struct ReelPager: View {
    public typealias Data = Reel<MediaFile>
    @State var pageIndex: Int
    @State var reels: [Data]
    @State var currentReel: String
    public init(pageIndex: Int = 0, reels: [Data] = []) {
        self.pageIndex = pageIndex
        self.reels = reels

        self.currentReel = reels.first?.id ?? ""
    }

    public var body: some View {

        VPageView(selectedPage: $pageIndex, data: 0..<reels.count) { index in

            ReelPlayer<Data>(reel: $reels[index], currentReel: $currentReel)
                .tag(reels[index].id)
                .onDisappear {
                    reels[index].player?.replaceCurrentItem(with: nil)
                }

        }
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }


    }
}
public let reels = MediaFileJSON.map { medialFile -> Reel<MediaFile> in
    let path = Bundle.main.path(forResource: medialFile.url, ofType: "mp4") ?? ""
    let player = AVPlayer(url: URL(fileURLWithPath: path))
    return Reel<MediaFile>(player: player, mediaFile: medialFile)
}
struct ReelPager_Previews: PreviewProvider {
    static var previews: some View {
        ReelPager(reels: reels)
    }
}
