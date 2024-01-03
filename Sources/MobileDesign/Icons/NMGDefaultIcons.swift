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

    public var heart: UIImage { UIImage(resource: ImageResource.heart) }

    public var heartFill: UIImage { UIImage(resource: ImageResource.heartFill) }

    public var arrowUpFromSquare: UIImage { UIImage(resource: ImageResource.share) }

    public var circlePlay: UIImage { UIImage(resource: ImageResource.circlePlay) }

    public var circleLoading: UIImage { UIImage(resource: ImageResource.circleLoading) }

    public var circleArrowLeftToLine: UIImage { UIImage(resource: ImageResource.circleArrowLeftToLine) }

    public var circleArrowRightToLine: UIImage { UIImage(resource: ImageResource.circleArrowRightToLine) }

    public var circlePause: UIImage { UIImage(resource: ImageResource.circlePause) }

    public var circleReplay: UIImage { UIImage(resource: ImageResource.circleReplay) }

    public var naviTVIcon: UIImage { UIImage() }

    public var tabIconTVSelected: UIImage { UIImage() }

    public var tabIconTV: UIImage { UIImage() }

    public var videoDetailLanding: UIImage { UIImage() }

}
