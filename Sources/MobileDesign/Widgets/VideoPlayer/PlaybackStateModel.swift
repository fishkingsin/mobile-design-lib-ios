//
//  PlaybackStateModel.swift
//  
//
//  Created by James Kong on 31/12/2023.
//

import Foundation

public class PlaybackStateModel: ObservableObject {
    @Published public private(set) var playbackState: VideoPlayerControlState
    public init(playbackState: VideoPlayerControlState) {
        self.playbackState = playbackState
    }
    public func updateState(playbackState: VideoPlayerControlState) {
        self.playbackState = playbackState
    }
}
