//
// NMGThemeableIcons.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

public protocol NMGThemeableIcons: AnyObject {
    var warnning: UIImage { get }
    var exclamationmarkCircle: UIImage { get }
    
    // ED
    var naviTVIcon: UIImage { get }
    var tabIconTVSelected: UIImage { get }
    var tabIconTV: UIImage { get }
    var tvDetailLanding: UIImage { get }
}
