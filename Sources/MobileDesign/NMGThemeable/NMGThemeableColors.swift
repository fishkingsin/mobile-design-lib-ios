//
// NMGThemeableColors.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

public protocol NMGThemeableColors: AnyObject, Hashable {
    var baseFolder: String { get }

    var primaryMain: UIColor { get }

    // common
    var black: UIColor { get }
    var white: UIColor { get }
    var alert: UIColor { get }
    var success: UIColor { get }
    var headline: UIColor { get }
    var footnote: UIColor { get }
    var neutralGray2: UIColor { get }
    var neutralGray5: UIColor { get }
    var neutralGray80: UIColor { get }
    var neutralGray70: UIColor { get }
    var neutralGray60: UIColor { get }
    var neutralGray50: UIColor { get }
    var neutralGray40: UIColor { get }
    var neutralGray30: UIColor { get }
    var neutralGray20: UIColor { get }
    var neutralGray10: UIColor { get }
    var neutralGray90: UIColor { get }
    var tabSelectedForegroud: UIColor { get }
    var tabSelectedBackgroud: UIColor { get }
    var tabForegroud: UIColor { get }
    var tabBackgroud: UIColor { get }
}

public extension NMGThemeableColors {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.primaryMain == rhs.primaryMain
    }

    func hash(into hasher: inout Hasher) {

        hasher.combine(primaryMain)
    }
}

public extension NMGThemeableColors {
    var primaryMain: UIColor { UIColor.color(from: baseFolder, named: "PrimaryMain")! }
    var black: UIColor { UIColor.color(from: "Common", named: "Black")! }
    var white: UIColor { UIColor.color(from: "Common", named: "White")! }
    var alert: UIColor { UIColor.color(from: "Common", named: "Alert")! }
    var success: UIColor { UIColor.color(from: "Common", named: "Success")! }
    var headline: UIColor { neutralGray70 }
    var footnote: UIColor { neutralGray30 }
    var neutralGray2: UIColor { UIColor.color(from: "Common", named: "NeutralGray2")! }
    var neutralGray5: UIColor { UIColor.color(from: "Common", named: "NeutralGray5")! }
    var neutralGray80: UIColor { UIColor.color(from: "Common", named: "NeutralGray80")! }
    var neutralGray70: UIColor { UIColor.color(from: "Common", named: "NeutralGray70")! }
    var neutralGray60: UIColor { UIColor.color(from: "Common", named: "NeutralGray60")! }
    var neutralGray50: UIColor { UIColor.color(from: "Common", named: "NeutralGray50")! }
    var neutralGray40: UIColor { UIColor.color(from: "Common", named: "NeutralGray40")! }
    var neutralGray30: UIColor { UIColor.color(from: "Common", named: "NeutralGray30")! }
    var neutralGray20: UIColor { UIColor.color(from: "Common", named: "NeutralGray20")! }
    var neutralGray10: UIColor { UIColor.color(from: "Common", named: "NeutralGray10")! }
    var neutralGray90: UIColor { UIColor.color(from: "Common", named: "NeutralGray90")! }
    var tabSelectedForegroud: UIColor { neutralGray2 }
    var tabSelectedBackgroud: UIColor { neutralGray90 }
    var tabForegroud: UIColor { neutralGray90 }
    var tabBackgroud: UIColor { neutralGray5 }
    //    public var textPrimary: UIColor { UIColor.color(from: "Default", named: "primary")! }
    internal func properties() -> [String: UIColor] {
        [
            "primaryMain": primaryMain
        ]
    }

    internal func common() -> [String: UIColor] {
        [
            "Black": black,
            "White": white,
            "Alert": alert,
            "Success": success,
            "neutralGray5": neutralGray5,
            "neutralGray80": neutralGray80,
            "neutralGray70": neutralGray70,
            "neutralGray60": neutralGray60,
            "neutralGray50": neutralGray50,
            "neutralGray40": neutralGray40,
            "neutralGray30": neutralGray30,
            "neutralGray20": neutralGray20,
            "neutralGray10": neutralGray10,
            "neutralGray90": neutralGray90
        ]
    }
}
