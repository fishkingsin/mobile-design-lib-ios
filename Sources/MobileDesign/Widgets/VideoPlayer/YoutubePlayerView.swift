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

public struct YoutubePlayerView: ViewRepresentableHelper {
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
    public var completion: (YTPlayerView) -> Void
    public var onStateChange: (YTPlayerState) -> Void

    public init(configuration: YoutubePlayerView.Configuration = .init(), completion: @escaping (YTPlayerView) -> Void, onStateChange: @escaping (YTPlayerState) -> Void) {
        self.configuration = configuration
        self.completion = completion
        self.onStateChange = onStateChange
    }

    public func new(_ context: Context) -> YTPlayerView {
        let youtubePlayerView = YTPlayerView(frame: .zero)
        youtubePlayerView.delegate = context.coordinator
        return youtubePlayerView
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
            debugPrint("playerViewDidBecomeReady")
        }

        public func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
            debugPrint("playerView error \(error)")
        }

        public func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
            parent.onStateChange(state)
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
