//
// NMGDefaultFonts.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

open class NMGDefaultFonts: NMGThemeableFonts {
    public init() {}

    /*
     https://github.com/lionhylra/iOS-UIFont-Names/blob/master/README.md
     PingFang TC    PingFangTC-Regular      let font = UIFont(name: "PingFangTC-Regular", size: .systemFontSize)!
     PingFang TC    PingFangTC-Thin         let font = UIFont(name: "PingFangTC-Thin", size: .systemFontSize)!
     PingFang TC    PingFangTC-Medium       let font = UIFont(name: "PingFangTC-Medium", size: .systemFontSize)!
     PingFang TC    PingFangTC-Semibold     let font = UIFont(name: "PingFangTC-Semibold", size: .systemFontSize)!
     PingFang TC    PingFangTC-Light        let font = UIFont(name: "PingFangTC-Light", size: .systemFontSize)!
     PingFang TC    PingFangTC-Ultralight   let font = UIFont(name: "PingFangTC-Ultralight", size: .systemFontSize)!
     */

    private func regular(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }

    private func thin(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Thin", size: size) ?? .systemFont(ofSize: size, weight: .thin)
    }

    private func medium(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }

    private func semibold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Semibold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }

    private func light(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Light", size: size) ?? .systemFont(ofSize: size, weight: .light)
    }

    private func ultraLight(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "PingFangTC-Ultralight", size: size) ?? .systemFont(ofSize: size, weight: .ultraLight)
    }

    open var eleSemiBold24: UIFont { semibold(ofSize: 24) }
    open var eleSemiBold22: UIFont { semibold(ofSize: 22) }

    open var eleMedium18: UIFont { medium(ofSize: 18) }
    open var eleMedium14: UIFont { medium(ofSize: 14) }

    open var eleRegular24: UIFont { regular(ofSize: 24) }
    open var eleRegular18: UIFont { regular(ofSize: 18) }
    open var eleRegular16: UIFont { regular(ofSize: 16) }
    open var eleRegular14: UIFont { regular(ofSize: 14) }
    open var eleRegular12: UIFont { regular(ofSize: 12) }
    open var eleRegular10: UIFont { regular(ofSize: 10) }

    open var carouselTitle: UIFont { semibold(ofSize: 20)}
    open var cardTitle: UIFont { medium(ofSize: 16) }
    open var cardContent: UIFont { regular(ofSize: 14) }

    open var articleH1: UIFont { semibold(ofSize: 20) }
    open var articleH2: UIFont { semibold(ofSize: 16) }
    open var articleH3: UIFont { semibold(ofSize: 16) }
    open var articleContent: UIFont { regular(ofSize: 16) }
    open var articleDescription: UIFont { regular(ofSize: 14) }
}
