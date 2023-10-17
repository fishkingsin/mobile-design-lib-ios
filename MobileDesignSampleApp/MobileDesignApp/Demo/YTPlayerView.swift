//
//  YTPlayerView.swift
//  MobileDesignSampleApp
//
//  Created by James Kong on 22/9/2023.
//

import SwiftUI
import YouTubeiOSPlayerHelper
import MobileDesign

public struct YoutubePlayerView: ViewRepresentableHelper {
    var isAutoplay: Bool

    public var completion: (YTPlayerView) -> Void
    public init(isAutoplay: Bool = false, completion: @escaping (YTPlayerView) -> Void) {
        self.isAutoplay = isAutoplay
        self.completion = completion

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
            if self.parent.isAutoplay {
                playerView.playVideo()
            }
        }

        public func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
            debugPrint("playerView error \(error)")
        }

    }
}
struct YoutubePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubePlayerView {
            $0.load(withVideoId: "4oAqg0YlIGQ")
            $0.playVideo()
        }
    }
}
