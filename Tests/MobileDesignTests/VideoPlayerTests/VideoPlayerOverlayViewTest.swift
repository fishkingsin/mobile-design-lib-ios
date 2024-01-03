//
//  VideoPlayerControlInitViewTest.swift
//
//
//  Created by James Kong on 30/12/2023.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign

final class VideoPlayerOverlayViewTest: XCTestCase {

  override func setUpWithError() throws {

  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_snapshot_default() throws {
    let theme = ThemeManager.shared.currentTheme
    let data = MockVideoDisplayable(
      imageURL: "placeholder",
      headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
      leadingFootnote: "4小時前",
      secondFootnote: "經人觀點",
      id: 1, url: "", videoType: "")
    [
      VideoPlayerControlState.COMPLETED,
      VideoPlayerControlState.REPLAY,
      VideoPlayerControlState.READY,
      VideoPlayerControlState.INIT,
    ].forEach { element in
      let model = PlaybackStateModel(playbackState: element)

      let rootView = VStack {
        VideoPlayerOverlayView(
          data: data,
          model: model
        ) {
          VideoPlayerControl(model: model) {

          }
        } upcomingContent: {
          UpcomingVideoView(item: data) {

          } nextVideoAction: {

          }
        }
        .aspectRatio(16 / 9, contentMode: .fit)
      }
      let vc = UIHostingController(rootView: rootView)
      vc.overrideUserInterfaceStyle = .light
      let expectation = expectation(description: "loading image")
      vc.viewDidLoad()
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        if let view = vc.view {
          assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro), named: element.rawValue)
        } else {
          XCTFail("view not found")
        }
        expectation.fulfill()
      }

      wait(for: [expectation], timeout: 3)
    }
  }

}
