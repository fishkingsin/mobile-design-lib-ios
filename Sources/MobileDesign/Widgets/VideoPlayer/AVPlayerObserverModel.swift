//
//  AVPlayerObserverModel.swift
//  
//
//  Created by James Kong on 6/1/2024.
//

import MobileDesign
import SwiftUI
import AVKit
import Combine

public class AVPlayerObserverModel: ObservableObject {
    @Published public var duration: TimeInterval = 0.0
    @Published public var currentTime: TimeInterval = 0.0

    let player: AVPlayer

    public init(
        player: AVPlayer = AVPlayer(),
        duration: TimeInterval = 0.0,
        currentTime: TimeInterval = 0.0
    ) {
        self.player = player
        self.duration = duration
        self.currentTime = currentTime
    }

    private var timeObserver: Any?

    func onAppear() {
        addPeriodicTimeObserver()
    }

    func onDisappear() {
        removePeriodicTimeObserver()
    }

    func pause() {
        player.pause()
    }

    func play() {
        player.play()
    }

    func seek(_ to: Double) {
        guard let duration = VideoHelper.getDuration(player) else { return }
        player.seek(to: CMTimeMultiplyByFloat64(duration, multiplier: Float64(to)))
    }

    /// Adds an observer of the player timing.
    private func addPeriodicTimeObserver() {
        // Create a 0.5 second interval time.
        let interval = CMTime(value: 1, timescale: 2)
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval,
                                                      queue: .main) { [weak self] time in
            guard let self else { return }
            // Update the published currentTime and duration values.
            currentTime = time.seconds
            duration = player.currentItem?.duration.seconds ?? 0.0
        }
    }


    /// Removes the time observer from the player.
    private func removePeriodicTimeObserver() {
        guard let timeObserver else { return }
        player.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }
}
