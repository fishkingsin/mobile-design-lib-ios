//
// CustomVideoPlayer.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import AVKit

import SwiftUI

import UIKit

struct CustomVideoPlayer: UIViewControllerRepresentable {

    var player: AVPlayer

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {

        let controller = AVPlayerViewController()

        controller.player = player
        controller.showsPlaybackControls = false

        controller.videoGravity = .resizeAspectFill

        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }

    class Coordinator: NSObject {

        var parent: CustomVideoPlayer

        init(parent: CustomVideoPlayer) {
            self.parent = parent
        }

        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
        }
    }
}
