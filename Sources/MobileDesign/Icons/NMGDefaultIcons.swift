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
    
    public var naviTVIcon: UIImage  { UIImage() }
    
    public var tabIconTVSelected: UIImage  { UIImage() }
    
    public var tabIconTV: UIImage  { UIImage() }
     
    public var tvDetailLanding: UIImage  { UIImage() }
    
    public var tvDetailLoading: UIImage  { UIImage() }
    
    public var tvLike: UIImage  { UIImage.image(from: "Default", named: "Like")! }
    
    public var tvLiked: UIImage  { UIImage.image(from: "Default", named: "Liked")! }
    
    public var tvShare: UIImage  { UIImage.image(from: "Default", named: "Share")! }
}
