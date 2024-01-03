//
// CustomVideoPlayer.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import AVKit

import SwiftUI

import UIKit

public struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer

    public init(player: AVPlayer) {
        self.player = player
    }

    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }

    public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {

    }
}
