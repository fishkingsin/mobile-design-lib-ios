//
//  VideoPlayerControlYT.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import YouTubePlayerKit

extension YouTubePlayer.PlaybackState {
    var toPlaybackState: VideoPlayerControlState {
        switch self {
            case .ended:
                return .COMPLETED
            case .playing:
                return .PLAYING
            case .paused:
                return .PAUSED
            case .buffering:
                return .LOADING
            default :
                return .UNKNOWN
        }
    }
}

public struct VideoPlayerControlYT<Source, VideoControlContent, Content>: View where
Source: VideoPlayerSourceProtocol,
VideoControlContent: View,
Content: View  {
    private let tag: String = "[VideoPlayerControlYT]"
    let source: Source
    let theme = ThemeManager.shared.currentTheme
    let viewControlContent: VideoControlContent
    var upcomingVideoView: Content
    let playbackStateModel: PlaybackStateModel

    @StateObject var youTubePlayer: YouTubePlayer = YouTubePlayer(
        configuration: .init(
            allowsPictureInPictureMediaPlayback: false,
            autoPlay: true,
            showCaptions: false,
            loopEnabled: false,
            useModestBranding: true,
            showRelatedVideos: false
        )
    )

    public init(
        _ source: Source,
        playbackStateModel: PlaybackStateModel,
        @ViewBuilder viewControlContent: @escaping () -> VideoControlContent,
        @ViewBuilder upcomingVideoView: @escaping () -> Content
    ) {
        self.source = source
        self.playbackStateModel = playbackStateModel
        self.viewControlContent = viewControlContent()
        self.upcomingVideoView = upcomingVideoView()
    }


    public var body: some View {
        ZStack(alignment: .center) {
            YouTubePlayerView(youTubePlayer) { state in
                VideoPlayerOverlayView(
                    data: source, model: playbackStateModel) {
                        VideoPlayerControl(model: playbackStateModel) {
                            youTubePlayer.play()
                        }

                    } upcomingContent: {
                        upcomingVideoView
                    }
            }.onReceive(youTubePlayer.statePublisher, perform: { state in
                debugPrint("\(tag) statePublisher \(state)")
                if state == .ready {
                    playbackStateModel.updateState(playbackState: .READY)
                }
            }).onReceive(youTubePlayer.playbackStatePublisher, perform: { state in
                debugPrint("\(tag) playbackStatePublisher \(state)")
                playbackStateModel.updateState(playbackState: state.toPlaybackState)
            }).onChange(of: source) { source in
                debugPrint("\(tag) onChange source \(source)")
                playbackStateModel.updateState(playbackState: .INIT)
                self.youTubePlayer.stop()
                self.youTubePlayer.source = .url(source.videoURL)
            }.onAppear {
                playbackStateModel.updateState(playbackState: .INIT)
                self.youTubePlayer.source = .url(source.videoURL)
            }
            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)

        }.tag(source.id)
    }
}
/* unable to preivew from package bundle
 #Preview {
 VideoPlayerControlYT(
 VideoPlayerSource(
 videoURL: "https://www.youtube.com/watch?v=q5D55G7Ejs8", title: "屯門33年漫畫小店", imageURL: "https://placehold.co/600x400/png"
 ), onStateChange: {
 debugPrint("onStateChange \($0)")
 }
 )
 }
 */
