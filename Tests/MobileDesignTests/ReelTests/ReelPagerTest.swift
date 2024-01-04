//
//  ReelPagerTest.swift
//
//
//  Created by James Kong on 10/9/2023.
//

import AVFoundation
import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign

final class ReelPagerTest: XCTestCase {

  override func setUpWithError() throws {
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_default_reel_pager_snapshot() throws {
    let rootView = sut
    let vc = UIHostingController(rootView: rootView)
    vc.overrideUserInterfaceStyle = .light

    let expectation = expectation(description: "loading reels")
    vc.viewDidLoad()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

      if let view = vc.view {
        assertSnapshot(matching: vc, as: .image(on: .iPhone13(.portrait)))
      } else {
        XCTFail("view not found")
      }
      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 2)
  }

  var sut: some View {
    ReelsPager(
      currentReelID: "1",
      reels: [
        Reel<MediaFile>(
          player: AVPlayer(),
          mediaFile: MediaFile(
            url: "Reel-1", title: "@經一速遞",
            content:
              "若從每人身上賺1元大餅，已是14個億的大茶飯，難度在於中間化零為整的手段。滴灌通主席李小加就想到了破解方案，兼開發出複利生財的投資模式，有如太極生兩儀、兩儀生四象。薑是老的辣，61歲的他下海創業，把生意經的算盤敲得響噹噹。"
          ))
      ])
  }
}
