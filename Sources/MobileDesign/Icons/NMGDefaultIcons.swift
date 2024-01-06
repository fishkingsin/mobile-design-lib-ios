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

    public var heart: UIImage { UIImage(resource: .heart) }

    public var heartFill: UIImage { UIImage(resource: .heartFill) }

    public var arrowUpFromSquare: UIImage { UIImage(resource: .share) }

    public var circlePlay: UIImage { UIImage(resource: .circlePlay) }

    public var circleLoading: UIImage { UIImage(resource: .circleLoading) }

    public var circleArrowLeftToLine: UIImage { UIImage(resource: .circleArrowLeftToLine) }

    public var circleArrowRightToLine: UIImage { UIImage(resource: .circleArrowRightToLine) }

    public var circlePause: UIImage { UIImage(resource: .circlePause) }

    public var circleReplay: UIImage { UIImage(resource: .circleReplay) }

    public var expand: UIImage { UIImage(resource: .expand) }

    public var naviTVIcon: UIImage { UIImage() }

    public var tabIconTVSelected: UIImage { UIImage() }

    public var tabIconTV: UIImage { UIImage() }

    public var videoDetailLanding: UIImage { UIImage(systemName: "arrow.right.circle.fill") ?? UIImage() }

}
