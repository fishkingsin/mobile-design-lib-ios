//
// DemoModels.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import CalendarPicker
import Charts
import Foundation
import MobileDesign
import SwiftUI
import UIKit

protocol DemoModel: CustomStringConvertible {
    var action: (UIViewController) -> Any? { get }
}

class ColorPaletteDemoModel: DemoModel {
    var description: String { "ColorPalette" }
    var action: ((UIViewController) -> Any?) = { viewController -> Any? in
        let newViewController = UIHostingController(rootView: ColorPaletteDemo())
        viewController.navigationController?.pushViewController(newViewController, animated: true)
        return newViewController
    }
}
