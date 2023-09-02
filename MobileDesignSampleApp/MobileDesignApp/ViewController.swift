//
// ViewController.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import MobileDesign
import SwiftUI
import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        ThemeManager.shared.applyTheme(NMGDefaultTheme())
//        let hostingView = UIHostingController(rootView: ColorPaletteDemo())
        let hostingView = UIHostingController(rootView: Gallery())
        addChild(hostingView)
        if let subview = hostingView.view {
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)

            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                subview.topAnchor.constraint(equalTo: view.topAnchor),
                subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                subview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        view.backgroundColor = .systemBackground
    }
}
