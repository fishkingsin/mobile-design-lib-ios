//
// FontsSnapshotTests.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import XCTest
@testable import MobileDesign
import SwiftUI
import SnapshotTesting

final class FontsSnapshotTests: XCTestCase {

    override func setUpWithError() throws {
//        isRecording = true

    }

    func test_font_snapshot() {
        let fonts = NMGDefaultFonts().properties

        Array(fonts).sorted { a, b in
            a.value.pointSize > b.value.pointSize
        }.map{ $0.key }.forEach { key in
            let vc = UIHostingController(
                rootView: FontItem(
                    key: key,
                    font: fonts[key]!.uiFont,
                    size: fonts[key]!.pointSize
                )
            )
            guard let view = vc.view else { fatalError() }
            vc.overrideUserInterfaceStyle = .dark
            assertSnapshot(matching: vc, as: .image(size: view.intrinsicContentSize), named: "\(key) dark" )
            vc.overrideUserInterfaceStyle = .light
            assertSnapshot(matching: vc, as: .image(size: view.intrinsicContentSize), named: "\(key) light" )
        }
    }

}
