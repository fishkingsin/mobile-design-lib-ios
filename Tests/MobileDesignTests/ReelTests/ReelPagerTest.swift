//
//  ReelPagerTest.swift
//
//
//  Created by James Kong on 10/9/2023.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign
import AVFoundation

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
    ReelsPager(currentReelID: "1", reels: [Reel<MediaFile>(player: AVPlayer(), mediaFile: MediaFile(url: "Reel-1", title: "@經一速遞", content: "飲飲食食的小生意，對於疊水的投資者，缺乏性感的想像空間."))])
  }
}
