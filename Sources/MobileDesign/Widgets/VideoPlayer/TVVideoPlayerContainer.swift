//
// ShareSheet.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import YouTubePlayerKit
import AVFoundation
import Kingfisher

public struct TVVideoPlayerContainer<Data>: View where Data: CardDisplayable {
    var data: Data
    var size: CGSize
    var safeArea: EdgeInsets
    
    
    public init(
        size: CGSize,
        safeArea: EdgeInsets,
        data: Data,
        isYoutuber: Bool = false
    ) {
        self.size = size
        self.safeArea = safeArea
        self.data = data
        self.isYoutuber = isYoutuber
    }
    
    @StateObject
    var youTubePlayer = YouTubePlayer(
        source: .url("https://youtube.com/watch?v=psL_5RIBqnY"),
        configuration: YouTubePlayer.Configuration(
            fullscreenMode: .web
        )
    )
    var isYoutuber = false
    @State private var rotationAngle: CGFloat = 0


    public var body: some View {
        VStack {
            if isYoutuber {
                YouTubePlayerView(self.youTubePlayer) { state in
                    // Overlay ViewBuilder closure to place an overlay View
                    // for the current `YouTubePlayer.State`
                    switch state {
                    case .idle:
                        ZStack{
                            KFImage(URL(string: self.data.imageURL))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width)
                            ThemeManager.shared.currentTheme.icons.tvDetailLoading.uiImage
                                .resizable()
                                .frame(width: 60, height: 60)
                                .rotationEffect(.degrees(rotationAngle))
                                .onAppear() {
                                    withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                                        rotationAngle = 360.0
                                    }
                                }
                        }
                    case .ready:
                        EmptyView()
                    case .error(let error):
                        Text(verbatim: "YouTube player couldn't be loaded")
                    }
                }

            } else {
                CustomAVPlayer(size: size, safeArea: safeArea) {
                    ZStack{
                        KFImage(URL(string: self.data.imageURL))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width)
                                .padding(.top, 0)
                        ThemeManager.shared.currentTheme.icons.tvDetailLoading.uiImage
                            .resizable()
                            .frame(width: 60, height: 60)
                            .rotationEffect(.degrees(rotationAngle))
                            .onAppear() {
                                withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                                    rotationAngle = 360.0
                                }
                            }
                    }
                } finishView: {
                    UpcomingVideoView(item: MockUpcomingItem()).frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width).padding(.top, 6)

                }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width)
                    .zIndex(10001)
            }
            CardContentView(
                headline: data.headline,
                leadingFootnote: data.leadingFootnote,
                secondFootnote: data.secondFootnote
            )
        }

    }
}
