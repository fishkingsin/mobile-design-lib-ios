//
// MediaFile.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public struct MediaFile: MediaFileConsumerable {
    public var id = UUID().uuidString
    public var url: String
    public var title: String
    public var content: String
    public var isExpanded: Bool = false
    public init(url: String, title: String, content: String, isExpanded: Bool = false) {
        self.url = url
        self.title = title
        self.content = content
        self.isExpanded = isExpanded
    }
}
