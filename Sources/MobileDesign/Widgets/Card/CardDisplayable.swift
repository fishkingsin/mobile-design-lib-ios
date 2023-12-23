//
// CardDisplayable.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public protocol CardDisplayable {
    var imageURL: String { get }
    var headline: String { get }
    var leadingFootnote: String { get }
    var secondFootnote: String { get }
}

public protocol VideoDisplayable {
    var imageURL: String? { get }
    var headline: String? { get }
    var leadingFootnote: String? { get }
    var secondFootnote: String? { get }
    var id: Int? { get }
    var url: String? { get }
    var videoType: String? { get }
}

public protocol VideoPlayListDisplayable {
    var playList: [VideoDisplayable] { get }
}
