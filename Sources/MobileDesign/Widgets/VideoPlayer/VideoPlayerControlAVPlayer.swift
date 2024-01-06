//
//  VideoPlayerControlAVPlayer.swift
//  NMG News
//
//  Created by James Kong on 1/1/2024.
//  Copyright © 2024 New Media Group. All rights reserved.
//

import MobileDesign
import SwiftUI
import AVKit
import Combine

public struct VideoPlayerControlAVPlayer<Source, Content>: View where
Source: VideoPlayerSourceProtocol,
Content: View {
    private let tag: String = "[VideoPlayerControlYT]"
    let source: Source
    let theme = ThemeManager.shared.currentTheme
    var upcomingVideoView: Content
    let playbackStateModel: PlaybackStateModel
    @State private var secCountDown = 5
    @ObservedObject private var model: AVPlayerObserverModel

    @State var videoControlAlpha: CGFloat = 1.0
    @State private var timer: AnyCancellable?

    public init(
        _ source: Source,
        playbackStateModel: PlaybackStateModel,
        model: AVPlayerObserverModel = AVPlayerObserverModel(),
        @ViewBuilder upcomingVideoView: @escaping () -> Content
    ) {
        self.source = source
        self.model = model
        self.upcomingVideoView = upcomingVideoView()
        self.playbackStateModel = playbackStateModel


    }

    public var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                CustomVideoPlayer(player: model.player)
                    .frame(width: .infinity, height: .infinity)
                    .onTapGesture {
                        toggleVideoControl()
                    }
                VideoPlayerControl(
                    model: playbackStateModel
                    //                , currentTime: $model.currentTime
                    //                , total: model.duration
                ) {
                    if playbackStateModel.playbackState == .PLAYING {
                        model.player.pause()
                        playbackStateModel.updateState(playbackState: .PAUSED)
                        return
                    }

                    if playbackStateModel.playbackState == .PAUSED {
                        model.player.play()
                        playbackStateModel.updateState(playbackState: .PLAYING)
                        return
                    }

                } onLeadingIconClick: {

                } onTrailingIconClick: {

                } onRightBottomIconClick: {

                }
                .frame(width: .infinity, height: .infinity)
                .opacity(videoControlAlpha)

                if playbackStateModel.playbackState == .COMPLETED {
                    upcomingVideoView
                }
                VStack() {
                    Spacer().layoutPriority(1)
                    VideoControlProgressView(
                        sliderValue: $model.currentTime,
                        total: model.duration
                    ) {
                        model.pause()
                        model.seek($0)
                    } onEnded: { _ in

                        model.play()
                    }
                }

            }.layoutPriority(1)

        }
        .onChange(of: model.player.timeControlStatus) {
            print("timeControlStatus \($0)")
            if $0 == .playing {
                playbackStateModel.updateState(playbackState: .PLAYING)
                return
            }
            if $0 == .paused {
                playbackStateModel.updateState(playbackState: .PAUSED)
                return
            }
        }
        .onChange(of: playbackStateModel.playbackState) { playbackState in
            if playbackState == .PLAYING {
                self.startCountdown()
            }
        }
        .onAppear {
            self.model.onAppear()
            self.load(source: source)
            self.startCountdown()
        }
        .onDisappear {
            self.model.onDisappear()
            timer?.cancel()
        }
        .frame(width: .infinity)
        .background(theme.colors.neutralGray5.color)
    }


    private func toggleVideoControl() {

        withAnimation {
            videoControlAlpha = videoControlAlpha == 0 ? 1 : 0
        }
        secCountDown = videoControlAlpha == 0 ? 0 : 5
        if videoControlAlpha == 1 {
            startCountdown()
        }
    }

    private func load(source: Source) {
        guard let urlString = source.url, let url = URL(string: urlString)
        else {
            playbackStateModel.updateState(playbackState: .ERROR)
            return
        }
        let item = AVPlayerItem(url: url)
        model.player.replaceCurrentItem(with: item)
        model.player.play()
        playbackStateModel.updateState(playbackState: .PLAYING)
    }

    private func startCountdown() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { _ in
                if self.secCountDown > 0 {
                    self.secCountDown -= 1
                } else {
                    self.timer?.cancel()
                    withAnimation {
                        videoControlAlpha = 0
                    }
                }
            }
    }
}

#Preview {
    VideoPlayerControlAVPlayer(
        VideoPlayerSource(
            videoURL: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8", 
            title: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            imageURL: "https://placehold.co/1920x1080/png",
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "滴灌通主席李小加就想到了破解方案，兼開發出複利生財的投資模式，有如太極生兩儀、兩儀生四象。薑是老的辣，61歲的他下海創業，把生意經的算盤敲得更為響噹噹。滴灌通主席李小加就想到了破解方案，兼開發出複利生財的投資模式，有如太極生兩儀、兩儀生四象。薑是老的辣，61歲的他下海創業，把生意經的算盤敲得更為響噹噹。",
            secondFootnote: "",
            id: 1,
            videoType: ""
        ),
        playbackStateModel: PlaybackStateModel(playbackState: .INIT)
    ) {
        EmptyView()
    }
    .aspectRatio( 16 / 9 , contentMode: .fit)
}
