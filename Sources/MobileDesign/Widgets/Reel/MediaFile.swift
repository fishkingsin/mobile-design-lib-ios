//
// MediaFile.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public struct MedieFile: MediaFileConsumerable {
    public var url: String = ""

    public var title: String = ""

    public var isExpanded: Bool = false

    public var id = UUID().uuidString

    public init(url: String, title: String, isExpanded: Bool) {
        self.url = url
        self.title = title
        self.isExpanded = isExpanded
    }
}
