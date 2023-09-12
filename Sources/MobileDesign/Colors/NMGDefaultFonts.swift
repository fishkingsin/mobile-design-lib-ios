//
// NMGDefaultFonts.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

open class NMGDefaultFonts: NMGThemeableFonts {
    public init() {}
    open var largeTitleEmphasize: UIFont { .boldSystemFont(ofSize: 45) }
    open var titleEmphasize: UIFont { .boldSystemFont(ofSize: 24) }
    open var title1: UIFont { .systemFont(ofSize: 24) }
    open var title2: UIFont { .systemFont(ofSize: 18) }
    open var title3: UIFont { .systemFont(ofSize: 17) }
    open var title4: UIFont { .systemFont(ofSize: 20) }
    open var title2Emphasize: UIFont { .boldSystemFont(ofSize: 18) }
    open var title3Emphasize: UIFont { .boldSystemFont(ofSize: 17) }
    open var title4Emphasize: UIFont { .boldSystemFont(ofSize: 20) }
    open var title5: UIFont { .systemFont(ofSize: 22) }
    open var headline: UIFont { .systemFont(ofSize: 16) }
    open var headlineEmphasize: UIFont { .boldSystemFont(ofSize: 16) }
    open var primaryButton: UIFont { .systemFont(ofSize: 14) }
    open var captionEmphasize: UIFont { .boldSystemFont(ofSize: 12) }
    open var caption: UIFont { .systemFont(ofSize: 12) }
    open var caption2: UIFont { .systemFont(ofSize: 10) }
    open var caption3Emphasize: UIFont { .boldSystemFont(ofSize: 8) }
    open var naviTitle: UIFont { .systemFont(ofSize: 14) }
    open var body: UIFont { .systemFont(ofSize: 14) }
    open var bodyEmphasize: UIFont { .boldSystemFont(ofSize: 14) }
    open var futuraCondenseExtraBold: UIFont { UIFont(name: "Futura-CondensedExtraBold", size: 40)! }
    open var futuraCondenseBold: UIFont { UIFont(name: "Futura-CondensedExtraBold", size: 20)! }
    open var futura18: UIFont { UIFont(name: "Futura", size: 18)! }
    open var futuraCondenseBold18: UIFont { UIFont(name: "Futura-CondensedExtraBold", size: 18)! }
    open var pingFangHK16: UIFont { UIFont(name: "PingFangHK-Regular", size: 16)! }
}
