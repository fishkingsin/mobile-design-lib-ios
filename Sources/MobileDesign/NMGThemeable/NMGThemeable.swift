//
// NMGThemeable.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import Foundation
import UIKit
public protocol NMGThemeable: AnyObject {
    var colors: any NMGThemeableColors { get }
    var fonts: NMGThemeableFonts { get }
    var icons: NMGThemeableIcons { get }
}
