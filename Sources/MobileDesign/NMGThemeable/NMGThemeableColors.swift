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
  var chipSelectedForeground: UIColor { get }
  var chipSelectedBackground: UIColor { get }
  var chipForeground: UIColor { get }
  var chipBackground: UIColor { get }
}

extension NMGThemeableColors {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.primaryMain == rhs.primaryMain
  }

  public func hash(into hasher: inout Hasher) {

    hasher.combine(primaryMain)
  }
}

extension NMGThemeableColors {
  public var primaryMain: UIColor { UIColor.color(from: baseFolder, named: "PrimaryMain")! }
  public var black: UIColor { UIColor.color(from: "Common", named: "Black")! }
  public var white: UIColor { UIColor.color(from: "Common", named: "White")! }
  public var alert: UIColor { UIColor.color(from: "Common", named: "Alert")! }
  public var success: UIColor { UIColor.color(from: "Common", named: "Success")! }
  public var headline: UIColor { neutralGray70 }
  public var footnote: UIColor { neutralGray30 }
  public var neutralGray2: UIColor { UIColor.color(from: "Common", named: "NeutralGray2")! }
  public var neutralGray5: UIColor { UIColor.color(from: "Common", named: "NeutralGray5")! }
  public var neutralGray80: UIColor { UIColor.color(from: "Common", named: "NeutralGray80")! }
  public var neutralGray70: UIColor { UIColor.color(from: "Common", named: "NeutralGray70")! }
  public var neutralGray60: UIColor { UIColor.color(from: "Common", named: "NeutralGray60")! }
  public var neutralGray50: UIColor { UIColor.color(from: "Common", named: "NeutralGray50")! }
  public var neutralGray40: UIColor { UIColor.color(from: "Common", named: "NeutralGray40")! }
  public var neutralGray30: UIColor { UIColor.color(from: "Common", named: "NeutralGray30")! }
  public var neutralGray20: UIColor { UIColor.color(from: "Common", named: "NeutralGray20")! }
  public var neutralGray10: UIColor { UIColor.color(from: "Common", named: "NeutralGray10")! }
  public var neutralGray90: UIColor { UIColor.color(from: "Common", named: "NeutralGray90")! }
  public var chipSelectedForeground: UIColor { neutralGray2 }
  public var chipSelectedBackground: UIColor { neutralGray90 }
  public var chipForeground: UIColor { neutralGray90 }
  public var chipBackground: UIColor { neutralGray5 }
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
