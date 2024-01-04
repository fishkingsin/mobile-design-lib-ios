//
//  VideoPlayerSource.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public struct VideoPlayerSource: VideoPlayerSourceProtocol {
    public var imageURL: String?

    public var headline: String?

    public var leadingFootnote: String?

    public var secondFootnote: String?

    public var id: Int?

    public var url: String?

    public var videoType: String?

    public var videoURL: String

    public var title: String

    public init(videoURL: String, title: String, imageURL: String? = nil, headline: String? = nil, leadingFootnote: String? = nil, secondFootnote: String? = nil, id: Int? = nil, videoType: String? = nil) {
        self.imageURL = imageURL
        self.headline = headline
        self.leadingFootnote = leadingFootnote
        self.secondFootnote = secondFootnote
        self.id = id
        self.url = videoURL
        self.videoType = videoType
        self.videoURL = videoURL
        self.title = title
    }
}
