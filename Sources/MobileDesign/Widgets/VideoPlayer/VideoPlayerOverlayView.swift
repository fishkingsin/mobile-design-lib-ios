//
//  VideoPlayerOverlayView.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import MobileDesign
public struct VideoPlayerOverlayView<Data: VideoDisplayable, Content: View>: View {
    let data: Data
    let state: VideoPlayerControlState
    var ShouldShowUpComingView: Content?

    public init(data: Data, state: VideoPlayerControlState, @ViewBuilder ShouldShowUpComingView: () -> Content) {
        self.data = data
        self.state = state
        self.ShouldShowUpComingView = ShouldShowUpComingView()
    }

    public var body: some View {
        switch state {
            case .LOADING:
                VideoPlayerControlInitView(data: data)
            case .COMPLETED:
                ShouldShowUpComingView
            default:
                EmptyView()
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
        VStack {
            VideoPlayerOverlayView(
                data: data,
                state: .LOADING) {
                    UpcomingVideoView(item: data, isFinish: .constant(false)) {

                    } nextVideoAction: {

                    }

                }
                .aspectRatio(16 / 9, contentMode: .fit)

            VideoPlayerOverlayView(
                data: data,
                state: .COMPLETED) {
                UpcomingVideoView(item: data, isFinish: .constant(true)) {

                } nextVideoAction: {

                }

            }.aspectRatio(16 / 9, contentMode: .fit)
        }
    }
}
