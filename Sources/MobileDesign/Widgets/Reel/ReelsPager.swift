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

    @State var reels: [Reel<MediaFile>]

    public init(currentReel: String = "", reels: [Reel<MediaFile>]) {
        self.currentReel = currentReel
        self.reels = reels
    }

    public var body: some View {
        GeometryReader { proxy in

            TabView(selection: $currentReel) {
                ForEach($reels) { $reel in
                    ReelPlayer(reel: $reel, currentReel: $currentReel)
                        .frame(width: proxy.size.width)
                        .rotationEffect(Angle(degrees: -90))
                        .ignoresSafeArea(.all, edges: .all)
                        .tag(reel.id)
                        .onAppear {
                            let path = Bundle.main.path(forResource: reel.mediaFile.url, ofType: "mp4") ?? ""
                            reel.player?.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: path)))
                        }
                        .onDisappear {
                            reel.player?.replaceCurrentItem(with: nil)
                        }

                }
            }
            .rotationEffect(Angle(degrees: 90))
            .frame(width: proxy.size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: proxy.size.width)
        }
        .ignoresSafeArea(.all, edges: .all)
        .background(.black)
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}
