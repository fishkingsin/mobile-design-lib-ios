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

    class MockUpcomingItem: VideoDisplayable {
        var imageURL: String?
        
        var headline: String?
        
        var leadingFootnote: String?
        
        var secondFootnote: String?
        
        var id: Int?
        
        var url: String?
        
        var videoType: String?
        
        init(imageURL: String? = nil, headline: String? = nil, leadingFootnote: String? = nil, secondFootnote: String? = nil, id: Int? = nil, url: String? = nil, videoType: String? = nil) {
            self.imageURL = imageURL
            self.headline = headline
            self.leadingFootnote = leadingFootnote
            self.secondFootnote = secondFootnote
            self.id = id
            self.url = url
            self.videoType = videoType
        }

    }
  var sut: some View {
      UpcomingVideoView(item: MockUpcomingItem(
        headline: "headline",
        leadingFootnote: "leadingFootnote",
        secondFootnote: "secondFootnote"
      ), isFinish: .constant(true), onCancelTap: {

      }, nextVideoAction: {

      })
  }

}
