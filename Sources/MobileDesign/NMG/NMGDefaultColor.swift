//
// NMGDefaultColor.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import Foundation

public class NMGDefaultColors: NMGThemeableColors {
    public var baseFolder: String { "Default" }

    public init() {
        fatalError("""
        please selected the following theme

        ED
        WW
        KISS
        MORE
        GOTRIP
        OS
        NM

        """)
    }
}
