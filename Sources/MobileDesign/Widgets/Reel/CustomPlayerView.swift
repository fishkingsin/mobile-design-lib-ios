//
// CustomPlayerView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import AVKit
class PlayerViewModel: ObservableObject {
    @Published var avPlayer: AVPlayer? = nil
}

struct CustomPlayerView: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel

    init(url: URL) {
        if playerViewModel.avPlayer == nil {
            playerViewModel.avPlayer = AVPlayer(url: url)
        } else {
            playerViewModel.avPlayer?.pause()
            playerViewModel.avPlayer?.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
    }

    var body: some View {
        HStack {
            VideoPlayer(player: playerViewModel.avPlayer)
        }
    }
}
