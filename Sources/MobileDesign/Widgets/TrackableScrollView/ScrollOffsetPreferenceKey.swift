//
// ScrollOffsetPreferenceKey.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    public typealias Value = [CGFloat]

    public static var defaultValue: [CGFloat] = [0]

    public static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
