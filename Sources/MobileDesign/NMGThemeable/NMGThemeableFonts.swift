//
// NMGThemeableFonts.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

public protocol NMGThemeableFonts: AnyObject {
    var largeTitleEmphasize: UIFont { get }
    var titleEmphasize: UIFont { get }
    var title1: UIFont { get }
    var title2: UIFont { get }
    var title3: UIFont { get }
    var title4: UIFont { get }
    var title2Emphasize: UIFont { get }
    var title3Emphasize: UIFont { get }
    var title4Emphasize: UIFont { get }
    var title5: UIFont { get }
    var headline: UIFont { get }
    var headlineEmphasize: UIFont { get }
    var primaryButton: UIFont { get }
    var captionEmphasize: UIFont { get }
    var caption: UIFont { get }
    var caption2: UIFont { get }
    var caption3Emphasize: UIFont { get }
    var naviTitle: UIFont { get }
    var body: UIFont { get }
    var bodyEmphasize: UIFont { get }
    var futuraCondenseExtraBold: UIFont { get }
    var futuraCondenseBold: UIFont { get }
    var futura18: UIFont { get }
    var futuraCondenseBold18: UIFont { get }
    var pingFangHK16: UIFont {get}
}

extension NMGThemeableFonts {
    var properties: [String: UIFont] {
        [
            "largeTitleEmphasize": largeTitleEmphasize,
            "titleEmphasize": titleEmphasize,
            "title1": title1,
            "title2": title2,
            "title3": title3,
            "title3Emphasize": title3Emphasize,
            "title4Emphasize": title4Emphasize,
            "title5": title5,
            "headline": headline,
            "headlineEmphasize": headlineEmphasize,
            "primaryButton": primaryButton,
            "captionEmphasize": captionEmphasize,
            "caption": caption,
            "caption2": caption2,
            "caption3Emphasize": caption3Emphasize,
            "naviTitle": naviTitle,
            "body": body,
            "bodyEmphasize": bodyEmphasize,
            "pingFangHK16": pingFangHK16
        ]
    }
}
