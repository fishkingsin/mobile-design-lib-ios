//
// ReelsPager.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import PageView
import AVKit

public struct ReelsPager: View {
    @State var currentReelID = ""

    @State var reels: [Reel<MediaFile>]

    public init(currentReelID: String = "", reels: [Reel<MediaFile>]) {
        self.currentReelID = currentReelID
        self.reels = reels
    }

    public var body: some View {
        GeometryReader { proxy in

            TabView(selection: $currentReelID) {
                ForEach($reels) { $reel in
                    ReelPlayer(reel: $reel, currentReelID: $currentReelID)
                        .frame(width: proxy.size.width)
                        .rotationEffect(Angle(degrees: -90))
                        .ignoresSafeArea(.all, edges: .all)
                        .tag(reel.id)
                        .onAppear {
                            reel.player?.play()
                        }
                        .onDisappear {
                            reel.player?.pause()
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
            currentReelID = reels.first?.id ?? ""
        }
    }
}
