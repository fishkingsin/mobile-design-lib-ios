//
// NMGDefaultFonts.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

open class NMGDefaultFonts: NMGThemeableFonts {
    public init() {}
    
    open var eleSemiBold24: UIFont{.systemFont(ofSize: 24, weight: .semibold)}
    open var eleSemiBold22: UIFont{.systemFont(ofSize: 22, weight: .semibold)}
    
    open var eleMedium18: UIFont{.systemFont(ofSize: 18, weight: .medium)}
    open var eleMedium14: UIFont{.systemFont(ofSize: 14, weight: .medium)}
    
    open var eleRegular24: UIFont{.systemFont(ofSize: 24, weight: .regular)}
    open var eleRegular18: UIFont{.systemFont(ofSize: 18, weight: .regular)}
    open var eleRegular16: UIFont{.systemFont(ofSize: 16, weight: .regular)}
    open var eleRegular14: UIFont{.systemFont(ofSize: 14, weight: .regular)}
    open var eleRegular12: UIFont{.systemFont(ofSize: 12, weight: .regular)}
    open var eleRegular10: UIFont{.systemFont(ofSize: 10, weight: .regular)}
    
    open var carouselTitle: UIFont{.systemFont(ofSize: 20, weight: .semibold)}
    open var cardTitle: UIFont{.systemFont(ofSize: 16, weight: .medium)}
    open var cardContent: UIFont{.systemFont(ofSize: 14, weight: .regular)}
    
    open var articleH1: UIFont{.systemFont(ofSize: 20, weight: .semibold)}
    open var articleH2: UIFont{.systemFont(ofSize: 16, weight: .semibold)}
    open var articleH3: UIFont{.systemFont(ofSize: 16, weight: .semibold)}
    open var articleContent: UIFont{.systemFont(ofSize: 16, weight: .regular)}
    open var articleDescription: UIFont{.systemFont(ofSize: 14, weight: .regular)}
}
