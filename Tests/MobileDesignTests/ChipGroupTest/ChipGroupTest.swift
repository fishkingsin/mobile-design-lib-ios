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
  var id: String = UUID().uuidString

  var title: String

  init(_ title: String) {
    self.title = title
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

  func test_chip_group_view_dark_mode() {
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

  fileprivate var data: [ChipDataDemo] {
    stride(from: 1, to: 10, by: 1).map {
      ChipDataDemo("Title \($0)")
    }
  }

  private var sut: some View {
    ChipGroup(datas: data, index: 0) { _, _ in
    }
  }

}
