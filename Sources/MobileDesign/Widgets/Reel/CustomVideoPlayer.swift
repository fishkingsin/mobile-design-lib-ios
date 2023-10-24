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

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public func makeUIViewController(context: Context) -> AVPlayerViewController {

        let controller = AVPlayerViewController()

        controller.player = player
        controller.showsPlaybackControls = true

        controller.videoGravity = .resizeAspectFill

        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        do {
            try AVAudioSession
                .sharedInstance()
                .setCategory(
                    AVAudioSession.Category.playback,
                    mode: AVAudioSession.Mode.default,
                    options: []
                )
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }


        context.coordinator.statusObserver = player.observe(\.status) { player, observeSubject in
            print("stats old \(observeSubject.oldValue) new \(observeSubject.newValue)")
            if observeSubject.newValue == .readyToPlay {
                player.play()
            }
        }

        context.coordinator.currentItemObserver = player.observe(\.status) { player, observeSubject in
            print("stats old \(observeSubject.oldValue) new \(observeSubject.newValue)")
        }

        return controller
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }

    public class Coordinator: NSObject {
        var statusObserver: NSKeyValueObservation?
        var currentItemObserver: NSKeyValueObservation?

        var parent: CustomVideoPlayer

        init(parent: CustomVideoPlayer) {
            self.parent = parent
        }

        deinit {
            self.parent.player.replaceCurrentItem(with: nil)
        }

        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
        }

    }
}
