//
// NMGDefaultIcons.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit
open class NMGDefaultIcons: NMGThemeableIcons {
    public init() {}

    var baseFolder: String { "Default" }

    public var warnning: UIImage { UIImage(systemName: "chevron.right.circle.fill")! }

    public var exclamationmarkCircle: UIImage { UIImage(systemName: "exclamationmark.circle")! }
}
