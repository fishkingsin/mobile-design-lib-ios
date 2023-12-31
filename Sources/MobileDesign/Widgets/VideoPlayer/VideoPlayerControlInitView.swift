//
//  VideoPlayerControlInitView.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct VideoPlayerControlInitView<Data: VideoDisplayable>: View {
    var data: Data
    let theme = ThemeManager.shared.currentTheme
    @ObservedObject var playbackStateModel: PlaybackStateModel
    public init(
        data: Data,
        playbackStateModel: PlaybackStateModel
    ) {
        self.data = data
        self.playbackStateModel = playbackStateModel
    }
    public var body: some View {
        ZStack(alignment: .center) {
            AsyncImage(url: URL(string: data.imageURL ?? "")) {
                $0
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                theme.colors.neutralGray30.color
            }
            Button {

            } label: {
                Image(uiImage: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .aspectRatio(1, contentMode: .fit)
            }

        }
    }

    var icon: UIImage {
        switch playbackStateModel.playbackState {
            default:
                theme.icons.videoPlayerLoading
        }
    }
}

internal struct MockVideoDisplayable: VideoDisplayable {
    var imageURL: String? = "https://placehold.co/600x400/png"

    var headline: String?

    var leadingFootnote: String?

    var secondFootnote: String?

    var id: Int?

    var url: String?

    var videoType: String?

}

#Preview {
    VideoPlayerControlInitView(data: MockVideoDisplayable(), playbackStateModel: PlaybackStateModel(playbackState: .INIT))
}
