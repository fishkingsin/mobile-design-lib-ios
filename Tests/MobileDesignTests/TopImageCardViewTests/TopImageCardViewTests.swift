//
// TopImageCardViewTests.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import XCTest
import SwiftUI
import SnapshotTesting
import MobileDesign

class TopImageCardViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        isRecording = true
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
        TopImageCardView(
            imageUrl: "https://placehold.co/358x200/png",
            imageWidth: nil,
            imageHeight: 120)
        {
            Rectangle()
        } contentView: {
            Text("Content View")
                .padding()
        }.background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray.opacity(0.5), lineWidth: 1)
        )
        .padding()
    }
}
