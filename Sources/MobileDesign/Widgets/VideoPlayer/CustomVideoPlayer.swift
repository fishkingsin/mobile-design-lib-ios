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

    var completion: (AVPlayerViewController) -> Void

    public init(player: AVPlayer, completion: @escaping (AVPlayerViewController) -> Void) {
        self.player = player
        self.completion = completion
    }

    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        completion(controller)
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }

    public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {

    }
}


extension AVPlayerViewController {
    func enterFullScreen(animated: Bool) {
        perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
    }
    func exitFullScreen(animated: Bool) {
        perform(NSSelectorFromString("exitFullScreenAnimated:completionHandler:"), with: animated, with: nil)
    }
}
