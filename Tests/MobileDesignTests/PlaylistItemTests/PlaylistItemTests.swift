//
//  PlaylistItemTests.swift
//  
//
//  Created by Felix Fok Ka Chun on 18/10/2023.
//

import MobileDesign
import SnapshotTesting
import SwiftUI
import XCTest

final class PlaylistItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_default_play_list_snapshot() throws {
      let rootView = sut
      let vc = UIHostingController(rootView: rootView)
      vc.overrideUserInterfaceStyle = .light

      let expectation = expectation(description: "loading play list item")
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
        PlaylistItem<CardData>(data: CardData(
            imageURL: "https://placehold.co/358x200/png",
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點",
            timecode: "00:00"
        ))
    }

}
