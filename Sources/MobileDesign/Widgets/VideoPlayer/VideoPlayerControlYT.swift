//
//  VideoPlayerControlYT.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct VideoPlayerControlYT<Source>: View where Source: VideoPlayerSourceProtocol {
    private let tag: String = "[VideoPlayerControlYT]"
    let source: Source
    let theme = ThemeManager.shared.currentTheme

    let onStateChange: (VideoPlayerControlState) -> Void
    let config = YoutubePlayerView.Configuration(isAutoplay: true)
    public init(_ source: Source, onStateChange: @escaping (VideoPlayerControlState) -> Void) {
        self.source = source
        self.onStateChange = onStateChange

    }

    public var body: some View {
        ZStack(alignment: .center) {
            YoutubePlayerView(
                configuration: YoutubePlayerView.Configuration(isAutoplay: true)
            ) {
                $0.load(withVideoId: URL(string: source.videoURL)?.queryParameters?["v"] ?? "", playerVars: config.toPlayerVars)
            } onStateChange: {
                onStateChange($0.toVideoPlayerState)
            }
            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
        }
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
