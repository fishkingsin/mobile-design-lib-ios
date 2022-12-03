//
// NMGThemeableColors.swift
//
// Copyright © 2022 New Media Group. All rights reserved.
//

import Foundation
import UIKit

public protocol NMGThemeableColors: AnyObject, Hashable {
    var baseFolder: String { get }
    var secondaryHightlight: UIColor { get }
    var secondaryElementbg2: UIColor { get }
    var secondaryElementbg5: UIColor { get }
    var secondaryElementbg10: UIColor { get }
    var secondaryUnactivated: UIColor { get }
    var primaryMain: UIColor { get }

    // common
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
}

public extension NMGThemeableColors {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.secondaryHightlight == rhs.secondaryHightlight &&
            lhs.secondaryElementbg2 == rhs.secondaryElementbg2 &&
            lhs.secondaryElementbg5 == rhs.secondaryElementbg5 &&
            lhs.secondaryElementbg10 == rhs.secondaryElementbg10 &&
            lhs.secondaryUnactivated == rhs.secondaryUnactivated &&
            lhs.primaryMain == rhs.primaryMain
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(secondaryHightlight)
        hasher.combine(secondaryElementbg2)
        hasher.combine(secondaryElementbg5)
        hasher.combine(secondaryElementbg10)
        hasher.combine(secondaryUnactivated)
        hasher.combine(primaryMain)
    }
}

public extension NMGThemeableColors {
    var secondaryHightlight: UIColor { UIColor.color(from: baseFolder, named: "SecondaryHightlight")! }
    var secondaryElementbg2: UIColor { UIColor.color(from: baseFolder, named: "SecondaryElementbg2")! }
    var secondaryElementbg5: UIColor { UIColor.color(from: baseFolder, named: "SecondaryElementbg5")! }
    var secondaryElementbg10: UIColor { UIColor.color(from: baseFolder, named: "SecondaryElementbg10")! }
    var secondaryUnactivated: UIColor { UIColor.color(from: baseFolder, named: "SecondaryUnactivated")! }
    var primaryMain: UIColor { UIColor.color(from: baseFolder, named: "PrimaryMain")! }

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
    //    public var textPrimary: UIColor { UIColor.color(from: "Default", named: "primary")! }
    internal func properties() -> [String: UIColor] {
        [
            "secondaryHightlight": secondaryHightlight,
            "secondaryElementbg2": secondaryElementbg2,
            "secondaryElementbg5": secondaryElementbg5,
            "secondaryElementbg10": secondaryElementbg10,
            "secondaryUnactivated": secondaryUnactivated,
            "primaryMain": primaryMain
        ]
    }

    internal func common() -> [String: UIColor] {
        [
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
