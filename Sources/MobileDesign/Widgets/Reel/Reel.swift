//
// Reel.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import AVKit

public struct Reel<MediaFile>: ReelDataProtocol where MediaFile: MediaFileConsumerable {
    public static func == (lhs: Reel<MediaFile>, rhs: Reel<MediaFile>) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(mediaFile.title)
        hasher.combine(mediaFile.id)
        hasher.combine(mediaFile.isExpanded)
        hasher.combine(mediaFile.content)        
    }

    public typealias MediaFile = MediaFile

    public var player: AVPlayer?

    public var id = UUID().uuidString

    public var mediaFile: MediaFile

    public init(player: AVPlayer? = nil, mediaFile: MediaFile) {
        self.player = player
        self.mediaFile = mediaFile
    }
}
