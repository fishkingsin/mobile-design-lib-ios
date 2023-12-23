//
// FontsSnapshotTests.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign

final class FontsSnapshotTests: XCTestCase {

    override func setUpWithError() throws {
    }
    func test_all_fonts_snapshot() {
        let fonts = NMGDefaultFonts().properties
        let vc = UIHostingController(
            rootView: AnyView(
                VStack {
                    ForEach(
                        Array(fonts).sorted { a, b in
                            (a.value.pointSize, b.key) > (b.value.pointSize, a.key)
                        }.map { $0.key }, id: \.self) { key in

                            FontItem(
                                key: key,
                                font: fonts[key]!.uiFont,
                                size: fonts[key]!.pointSize
                            )

                        }
                }
            )
        )
        guard let view = vc.view else { fatalError() }
        vc.overrideUserInterfaceStyle = .dark
        assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro), named: " dark")
        vc.overrideUserInterfaceStyle = .light
        assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro), named: " light")
    }
    func test_font_snapshot() {
        let fonts = NMGDefaultFonts().properties

        Array(fonts).sorted { a, b in
            a.value.pointSize > b.value.pointSize
        }.map { $0.key }.forEach { key in
            let vc = UIHostingController(
                rootView: FontItem(
                    key: key,
                    font: fonts[key]!.uiFont,
                    size: fonts[key]!.pointSize
                )
            )
            guard let view = vc.view else { fatalError() }
            vc.overrideUserInterfaceStyle = .dark
            assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro), named: "\(key) dark")
            vc.overrideUserInterfaceStyle = .light
            assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro), named: "\(key) light")
        }
    }

}
