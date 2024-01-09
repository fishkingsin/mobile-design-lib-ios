//
// NMGThemeableFonts.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import UIKit

public protocol NMGThemeableFonts: AnyObject {
    var eleSemiBold24: UIFont { get }
    var eleSemiBold22: UIFont { get }
    var eleMedium18: UIFont { get }
    var eleMedium16: UIFont { get }
    var eleMedium14: UIFont { get }
    var eleRegular24: UIFont { get }
    var eleRegular18: UIFont { get }
    var eleRegular16: UIFont { get }
    var eleRegular14: UIFont { get }
    var eleRegular12: UIFont { get }
    var eleRegular10: UIFont { get }
    var carouselTitle: UIFont { get }
    var cardTitle: UIFont { get }
    var cardContent: UIFont { get }
    var articleH1: UIFont { get }
    var articleH2: UIFont { get }
    var articleH3: UIFont { get }
    var articleContent: UIFont { get }
    var articleDescription: UIFont { get }

}

extension NMGThemeableFonts {
    var properties: [String: UIFont] {
        [
            "eleSemiBold24": eleSemiBold24,
            "eleSemiBold22": eleSemiBold22,
            "eleMedium18": eleMedium18,
            "eleMedium16": eleMedium16,
            "eleMedium14": eleMedium14,
            "eleRegular24": eleRegular24,
            "eleRegular18": eleRegular18,
            "eleRegular16": eleRegular16,
            "eleRegular14": eleRegular14,
            "eleRegular12": eleRegular12,
            "eleRegular10": eleRegular10,
            "carouselTitle": carouselTitle,
            "cardTitle": cardTitle,
            "cardContent": cardContent,
            "articleH1": articleH1,
            "articleH2": articleH2,
            "articleH3": articleH3,
            "articleContent": articleContent,
            "articleDescription": articleDescription
        ]
    }
}
