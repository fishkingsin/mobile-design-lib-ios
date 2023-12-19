//
// ShareSheet.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import YouTubePlayerKit
import AVFoundation
import Kingfisher

public struct TVVideoPlayerContainer<Data>: View where Data: VideoDisplayable {
    var data: [Data]
    var size: CGSize
    var safeArea: EdgeInsets
    @State var currentPlayingData: Data
    @State var nextPlayData: Data

    public init(
        size: CGSize,
        safeArea: EdgeInsets,
        data: [Data]
    ) {
        self.size = size
        self.safeArea = safeArea
        self.data = data
        _currentPlayingData = State(initialValue: data.first!)
        _nextPlayData = State(initialValue: data.count > 1 ? data[1] : data[0])
        if let initData = data.first {
            if initData.videoType == "youtube", let youtubeURL = initData.url {
                self.youTubePlayer.load(source: .url(youtubeURL))
            }else if initData.videoType == "vimeo", let vimeoURLString = initData.url, let vimeoURL =  URL(string: vimeoURLString)  {
                let newPlayerItem = AVPlayerItem(url: vimeoURL)
                player?.replaceCurrentItem(with: newPlayerItem)
            }
        }
    }
    
    var youTubePlayer = YouTubePlayer(
        configuration: YouTubePlayer.Configuration(
            allowsPictureInPictureMediaPlayback: false,
            fullscreenMode: .web,
            autoPlay: true,
            showCaptions: false,
            loopEnabled: false,
            useModestBranding: true,
            showRelatedVideos: false
        )
    )
    
    @State private var player: AVPlayer? = {
        return AVPlayer()
    }()
    
    @State private var rotationAngle: CGFloat = 0
    @State private var isFinish: Bool = false

    public var body: some View {
        VStack {
            ZStack {
                if currentPlayingData.videoType == "youtube" {
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
                    CustomAVPlayer(size: size, safeArea: safeArea, player: $player) {
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
                headline: currentPlayingData.headline ?? "",
                leadingFootnote: currentPlayingData.leadingFootnote ?? "",
                secondFootnote: currentPlayingData.secondFootnote ?? ""
            )
        }
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        ZStack{
            KFImage(URL(string: self.currentPlayingData.imageURL ?? ""))
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
        UpcomingVideoView(item: nextPlayData, isFinish: $isFinish, onCancelTap: {
            self.youTubePlayer.seek(to: 0, allowSeekAhead: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.youTubePlayer.stop()
                self.player?.pause()
                isFinish = false
            }
        }, nextVideoAction: {
            self.youTubePlayer.seek(to: 0, allowSeekAhead: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if nextPlayData.videoType == "youtube", let youtubeURL = nextPlayData.url {
                    self.youTubePlayer.load(source: .url(youtubeURL))
                }else if nextPlayData.videoType == "vimeo", let vimeoURLString = nextPlayData.url, let vimeoURL =  URL(string: vimeoURLString)  {
                    let newPlayerItem = AVPlayerItem(url: vimeoURL)
                    player?.replaceCurrentItem(with: newPlayerItem)
                }
                currentPlayingData = nextPlayData
                let index = data.firstIndex(where: { $0.id == nextPlayData.id }) ?? 0
                if let indexData = data.count > index + 1 ? data[index + 1] : data.first {
                    nextPlayData = indexData
                }
                isFinish = false
            }
        }).frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 9.0/16.0 * UIScreen.main.bounds.width).padding(.top, 0).background(Color.white).padding(.top, 1)
    }
    
    
}
