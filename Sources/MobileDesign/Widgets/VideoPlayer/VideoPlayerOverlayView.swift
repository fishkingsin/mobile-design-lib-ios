//
//  VideoPlayerOverlayView.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import MobileDesign
public struct VideoPlayerOverlayView<Data, ReplayContent, UpcomingContent>: View where
Data: VideoDisplayable,
ReplayContent: View,
UpcomingContent: View {
    let data: Data?
    @ObservedObject var model: PlaybackStateModel
    var replayContent: ReplayContent?
    var upcomingContent: UpcomingContent?

    public init(data: Data?, model: PlaybackStateModel,
                @ViewBuilder replayContent: @escaping () -> ReplayContent,
                @ViewBuilder upcomingContent: @escaping () -> UpcomingContent) {
        self.data = data
        self.model = model
        self.replayContent = replayContent()
        self.upcomingContent = upcomingContent()
        debugPrint("[VideoPlayerControlYT] model.playbackState \(model.playbackState)")
    }

    public var body: some View {
        ZStack {
            switch model.playbackState {
                case .INIT, .READY:
                    if let data = data {
                        VideoPlayerControlInitView(data: data, playbackStateModel: model) {

                        }
                    }
                case .REPLAY:
                    replayContent
                case .COMPLETED:
                    upcomingContent
                default:

                    EmptyView()
            }
        }.onReceive(model.$playbackState) { state in
            debugPrint("[VideoPlayerControlYT] model.playbackState \(model) \(state)")
        }
    }
}
struct VideoPlayerOverlayView_Preview: PreviewProvider {

    static var previews: some View {
        let data = MockVideoDisplayable(
            imageURL: "https://placehold.co/1920x1080/png",
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點",
            id: 1, url: "", videoType: "")

        ScrollView {
            LazyVStack {
                ForEach(Array([
                    VideoPlayerControlState.COMPLETED,
                    VideoPlayerControlState.REPLAY,
                    VideoPlayerControlState.READY,
                    VideoPlayerControlState.INIT
                ].enumerated()), id: \.element) { _, element in
                    let model = PlaybackStateModel(playbackState: element)
                    VideoPlayerOverlayView(
                        data: data,
                        model: model) {
                            VideoPlayerControl(model: model) {

                            }
                        } upcomingContent: {
                            UpcomingVideoView(item: data) {

                            } nextVideoAction: {

                            }
                        }
                        .aspectRatio(16 / 9, contentMode: .fit)
                }
            }
        }
    }
}
