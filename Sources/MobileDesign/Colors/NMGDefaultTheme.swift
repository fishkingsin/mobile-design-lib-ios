//
// NMGDefaultTheme.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import Foundation
import UIKit

open class NMGDefaultTheme: NMGThemeable {
    public var colors: any NMGThemeableColors

    public var fonts: NMGThemeableFonts

    public var icons: NMGThemeableIcons

    public init(
        _ customColors: (() -> any NMGThemeableColors)? = nil,
        _ customFonts: (() -> NMGThemeableFonts)? = nil,
        _ customIcons: (() -> NMGThemeableIcons)? = nil
    ) {
        let customColors = customColors?()
        self.colors = customColors ?? NMGDefaultColors()

        let customFonts = customFonts?()
        self.fonts = customFonts ?? NMGDefaultFonts()

        let customIcons = customIcons?()
        self.icons = customIcons ?? NMGDefaultIcons()
    }
}
