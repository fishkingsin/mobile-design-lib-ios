//
// CardViewTests.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import MobileDesign
import SnapshotTesting
import SwiftUI
import XCTest

class CardViewTests: XCTestCase {

  override func setUp() {
      
    super.setUp()
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
        assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro))
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
        assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro))
      } else {
        XCTFail("view not found")
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 2)
  }

  private var sut: some View {
    VideoCardView<CardData>(
      data: CardData(
        imageURL: "",
        headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
        leadingFootnote: "4小時前",
        secondFootnote: "經人觀點",
        timecode: "22:22"
      ), onTabChanged: {
          print("pressed")
      }
    ).frame(minWidth: 320, minHeight: 680)
  }
}
