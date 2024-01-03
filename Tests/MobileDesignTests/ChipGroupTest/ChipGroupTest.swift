//
// ChipGroupTest.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign

private struct ChipDataDemo: ChipData {
    var id: Int?

    var name: String?

    var icon: String?

    var title: String

    var iconUrl: String

    init(name: String? = nil, icon: String? = nil, id: Int = Int.random(in: 0...100), title: String, iconUrl: String) {
        self.name = name
        self.icon = icon
        self.id  = id
        self.title = title
        self.iconUrl = iconUrl
    }

}

final class ChipGroupTest: XCTestCase {

  override func setUp() {
    super.setUp()

  }

  override func tearDown() {
    super.tearDown()
  }

  func test_chip_group_view_light_mode() {
    let rootView = sut
    let vc = UIHostingController(rootView: rootView)
    vc.overrideUserInterfaceStyle = .light

    let expectation = expectation(description: "loading image")
    vc.viewDidLoad()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

      if let view = vc.view {
        assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro))

      } else {
        XCTFail("view not found")
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 2)
  }

  func test_chip_group_view_dark_mode() {
    let rootView = sut
    let vc = UIHostingController(rootView: rootView)
    vc.overrideUserInterfaceStyle = .dark
    let expectation = expectation(description: "loading image")
    vc.viewDidLoad()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      if let view = vc.view {
        assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro))
      } else {
        XCTFail("view not found")
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 2)
  }

  fileprivate var data: [ChipDataDemo] { [
    ChipDataDemo(name: "Title 10", icon: "placholder", id: 0, title: "Title", iconUrl: "iconUrl"),
    ChipDataDemo(name: "Title 100", icon: "placholder", id: 1, title: "Title", iconUrl: "iconUrl"),
    ChipDataDemo(name: "Title 1000", icon: "placholder", id: 2, title: "Title", iconUrl: "iconUrl")]
  }

  private var sut: some View {
    ChipGroup(datas: data, index: 0) { _, _ in
    }
  }

}
