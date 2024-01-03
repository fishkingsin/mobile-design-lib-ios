//
//  YoutubePlayerView.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import YouTubeiOSPlayerHelper

extension YTPlayerState {
    var toVideoPlayerState: VideoPlayerControlState {
        switch self {
            case .buffering:
                return .LOADING
            case .playing:
                return .PLAYING
            case .paused:
                return .PAUSED
            case .ended:
                return .COMPLETED
            case .unknown, .unstarted:
                return .ERROR
            default:
                return .UNKNOWN
        }
    }
}

public struct YoutubePlayerView: UIViewRepresentable {
    public typealias ViewType = YTPlayerView
    public struct Configuration {
        let isAutoplay: Bool
        let enableRelatedVideo: Bool

        public init() {
            isAutoplay = false
            enableRelatedVideo = false
        }

        public init(
            isAutoplay: Bool = false,
            enableRelatedVideo: Bool = false
        ) {
            self.isAutoplay = isAutoplay
            self.enableRelatedVideo = enableRelatedVideo
        }

        // - MARK: youtube ifram player api vars
        var toPlayerVars: [String: Any] {
            var dic: [String: Any] = [:]
            dic["autoplay"] = isAutoplay ? 1 : 0
            dic["iv_load_policy"] = 3
            dic["rel"] = enableRelatedVideo ? 1 : 0
            return dic
        }
    }
    var configuration: Configuration
    public var completion: (ViewType, String) -> String
    public var onStateChange: (YTPlayerState) -> Void
    @State var videoId: String

    public init(
        videoId: String,
        configuration: YoutubePlayerView.Configuration = .init(),
        completion: @escaping (ViewType, String) -> String, onStateChange: @escaping (YTPlayerState) -> Void) {
            self.videoId = videoId
            self.configuration = configuration
            self.completion = completion
            self.onStateChange = onStateChange
        }

    public func makeUIView(context: UIViewRepresentableContext<YoutubePlayerView>) -> ViewType {
        let youtubePlayerView = YTPlayerView(frame: .zero)
        youtubePlayerView.delegate = context.coordinator
        youtubePlayerView.load(
            withVideoId: videoId,
            playerVars: configuration.toPlayerVars)
        return youtubePlayerView
    }

    public func updateView(_ view: ViewType, _ context: Context) {
        let newVideoID = completion(view, videoId)
        if newVideoID != videoId {
            self.videoId = newVideoID
        }
    }

    public func updateUIView(_ uiView: ViewType, context: UIViewRepresentableContext<YoutubePlayerView>) {
        updateView(uiView, context)
        debugPrint("[VideoPlayerControlYT] updateUIView \(uiView)")
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: NSObject, YTPlayerViewDelegate {
        var parent: YoutubePlayerView
        init(parent: YoutubePlayerView) {
            self.parent = parent
        }

        public func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
            debugPrint("[VideoPlayerControlYT] playerViewDidBecomeReady")
//            parent.onStateChange(.playing)
        }

        public func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
            debugPrint("[VideoPlayerControlYT] playerView error \(error)")
        }

        public func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
            debugPrint("[VideoPlayerControlYT] playerView didChangeTo \(state)")
            if state == .ended {
                parent.onStateChange(state)
            }
        }

    }
}
/* unable to preivew from package bundle
 struct YoutubePlayerView_Previews: PreviewProvider {
 static var previews: some View {
 YoutubePlayerView {
 $0.load(withVideoId: "4oAqg0YlIGQ")
 } onStateChange: {
 debugPrint("onStateChange \($0)")
 }
 }
 }
 */
