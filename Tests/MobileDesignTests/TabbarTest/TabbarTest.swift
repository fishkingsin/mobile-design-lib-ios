//
// TabbarTest.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import XCTest
import SwiftUI
@testable import MobileDesign
import SnapshotTesting
final class ChipGroupTest: XCTestCase {

    override func setUp() {
        super.setUp()
//        isRecording = true
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_top_image_card_view_light_mode() {
        let rootView = sut
        let vc = UIHostingController(rootView: rootView)
        vc.overrideUserInterfaceStyle = .light

        let expectation = expectation(description: "loading image")
        vc.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

            if let view = vc.view {
                assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize))
            } else {
                XCTFail("view not found")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func test_top_image_card_view_dark_mode() {
        let rootView = sut
        let vc = UIHostingController(rootView: rootView)
        vc.overrideUserInterfaceStyle = .dark
        let expectation = expectation(description: "loading image")
        vc.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let view = vc.view {
                assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize))
            } else {
                XCTFail("view not found")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    private var sut: some View {
        ChipGroupDemo(index: 0)
    }

}
