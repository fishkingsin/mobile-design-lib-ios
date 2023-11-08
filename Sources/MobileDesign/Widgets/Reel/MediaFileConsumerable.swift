//
// MediaFileConsumerable.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public protocol MediaFileConsumerable: Identifiable {
    var url: String { get }
    var title: String { get }
    var content: String { get }
    var isExpanded: Bool { get }
}
