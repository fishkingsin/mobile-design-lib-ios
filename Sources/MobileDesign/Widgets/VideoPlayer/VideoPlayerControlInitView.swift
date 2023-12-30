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
                Image(uiImage: theme.icons.videoPlayerLoading)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .aspectRatio(1, contentMode: .fit)
            }

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
    VideoPlayerControlInitView(data: MockVideoDisplayable())
}
