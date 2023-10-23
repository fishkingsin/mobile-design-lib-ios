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

final class UpcomingVideoViewTest: XCTestCase {

  override func setUpWithError() throws {
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_default_upcoming_video_snapshot() throws {
    let rootView = sut
    assertSnapshot(matching: rootView, as: .image(layout: .fixed(width: 390, height: 219)))
  }

  var sut: some View {
      UpcomingVideoView(item: MockUpcomingItem(), event: nil)
  }

}
