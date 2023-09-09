//
// ReelsPager.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import PageView
import AVKit


public struct ReelsPager: View {
    @State var currentReel = ""

    // demo
    @State var reels = MediaFileJSON.map { medialFile -> Reel<MediaFile> in
        let path = Bundle.main.path(forResource: medialFile.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        return Reel<MediaFile>(player: player, mediaFile: medialFile)
    }

    public init(currentReel: String = "", reels: [Reel<MediaFile>]) {
        self.currentReel = currentReel
    }

    public var body: some View {
        GeometryReader { proxy in

            TabView(selection: $currentReel) {
                ForEach($reels) { $reel in
                    ReelPlayer(reel: $reel, currentReel: $currentReel)
                        .frame(width: proxy.size.width)
                        .padding()
                        .rotationEffect(Angle(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reel.id)
                        .onAppear {
                            let path = Bundle.main.path(forResource: reel.mediaFile.url, ofType: "mp4") ?? ""
                            reel.player?.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: path)))
                        }
                        .onDisappear() {
                            reel.player?.replaceCurrentItem(with: nil)
                        }

                }
            }
            .rotationEffect(Angle(degrees: 90))
            .frame(width: proxy.size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: proxy.size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(.black)
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
        ReelsPager(currentReel: reels.first!.id, reels: reels)
    }
}
