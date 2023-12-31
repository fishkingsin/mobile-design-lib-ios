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

    public var heart: UIImage { UIImage(resource: ImageResource.like) }

    public var heartFill: UIImage { UIImage(resource: ImageResource.like) }

    public var arrowUpFromSquare: UIImage { UIImage(resource: ImageResource.share) }

    public var play: UIImage { UIImage(resource: ImageResource.play) }

    public var naviTVIcon: UIImage { UIImage() }

    public var tabIconTVSelected: UIImage { UIImage() }

    public var tabIconTV: UIImage { UIImage() }

    public var videoDetailLanding: UIImage { UIImage() }

    public var videoPlayerLoading: UIImage {  UIImage(resource: ImageResource.videoDetailLoading) }
}
