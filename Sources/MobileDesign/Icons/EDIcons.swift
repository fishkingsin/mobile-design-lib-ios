//
// EDColors.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

open class EDIcons: NMGDefaultIcons {
    override var baseFolder: String { "ED" }

    public override var naviTVIcon: UIImage { UIImage.image(from: baseFolder, named: "navi_tv_icon")! }

    public override var tabIconTVSelected: UIImage { UIImage.image(from: baseFolder, named: "tab_icon_tv_selected") ?? UIImage() }

    public override var tabIconTV: UIImage { UIImage.image(from: baseFolder, named: "tab_icon_tv")! }

    public override var videoDetailLanding: UIImage { UIImage.image(from: baseFolder, named: "video_detail_landing") ?? UIImage() }

}
