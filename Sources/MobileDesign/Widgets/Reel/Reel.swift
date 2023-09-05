//
// Reel.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import AVKit


public struct Reel<MedieFile>: ReelDataProtocol where MedieFile: MediaFileConsumerable {
    public static func == (lhs: Reel<MedieFile>, rhs: Reel<MedieFile>) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(title)
        hasher.combine(mediaFile.title)
        hasher.combine(mediaFile.id)
        hasher.combine(mediaFile.isExpanded)
    }

    public typealias MedieFile = MedieFile

    public var player: AVPlayer?

    public var id = UUID().uuidString

    public var title: String

    public var mediaFile: MedieFile

    public init(player: AVPlayer? = nil, title: String, mediaFile: MedieFile) {
        self.player = player
        self.title = title
        self.mediaFile = mediaFile
    }
}
