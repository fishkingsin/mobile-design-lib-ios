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
        source: .url("https://www.youtube.com/watch?v=hJVwKTBEbWE"),
        configuration: YouTubePlayer.Configuration(
            allowsPictureInPictureMediaPlayback: false,
            fullscreenMode: .web,
            autoPlay: true,
            loopEnabled: false,
            useModestBranding: true,
            showRelatedVideos: false
        )
    )
    var isYoutuber = false
    @State private var rotationAngle: CGFloat = 0
    @State private var isFinish: Bool = false
    @State private var showNextVideo: Bool = false

    public var body: some View {
        VStack {
            ZStack {
                if isYoutuber {
                    YouTubePlayerView(self.youTubePlayer) { state in
                        switch state {
                        case .idle:
                            loadingView()
                        case .ready:
                            EmptyView()
                        case .error(let error):
                            Text(verbatim: "YouTube player couldn't be loaded")
                        }
                    }.onReceive(
                        self.youTubePlayer
                            .playbackStatePublisher
                            .receive(on: DispatchQueue.main)
                    ) { state in
                        if state == .ended {
                            isFinish = true
                        }
                    }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width)
                } else {
                    CustomAVPlayer(size: size, safeArea: safeArea) {
                        loadingView()
                    } finishView: {
                        unComingView()

                    }.frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width)
                }
                if isFinish {
                    unComingView()
                }
            }
           
            CardContentView(
                headline: data.headline,
                leadingFootnote: data.leadingFootnote,
                secondFootnote: data.secondFootnote
            )
        }
    }
    
    @ViewBuilder
    func loadingView() -> some View {
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
    }
    
    @ViewBuilder
    func unComingView() -> some View {
        UpcomingVideoView(item: MockUpcomingItem(), isFinish: $isFinish, onCancelTap: {
            self.youTubePlayer.seek(to: 0, allowSeekAhead: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.youTubePlayer.stop()
                isFinish = false
            }
        }, nextVideoAction: {
            self.youTubePlayer.seek(to: 0, allowSeekAhead: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.youTubePlayer.load(source: .url("https://www.youtube.com/watch?v=uFh53Cg_vdQ"))
                isFinish = false
            }
        }).frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width).padding(.top, 0).background(Color.white).padding(.top, 1)
    }
}
