//
//  VideoPlayerSource.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public struct VideoPlayerSource: VideoPlayerSourceProtocol {
    public var videoURL: String

    public var title: String

    public var imageURL: String

    public init(videoURL: String, title: String, imageURL: String) {
        self.videoURL = videoURL
        self.title = title
        self.imageURL = imageURL
    }
}
