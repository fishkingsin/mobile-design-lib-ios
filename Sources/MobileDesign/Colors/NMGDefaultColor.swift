//
// NMGDefaultColor.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import Foundation

public class NMGDefaultColors: NMGThemeableColors {
    public var baseFolder: String

    public init(_ themeName: String = "Default") {
        self.baseFolder = themeName
    }
}
