//
//  HorizontalCardTests.swift
//  
//
//  Created by Felix Fok Ka Chun on 17/10/2023.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign

final class HorizontalCardTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_horizontal_card_snapshot() throws {
        let rootView = sut
        let vc = UIHostingController(rootView: rootView)
        vc.overrideUserInterfaceStyle = .light
        
        let expectation = expectation(description: "loading horizontal card")
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
        HorizontalCard(data: CardData(
            imageURL: "",
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點",
            timecode: "22:22"
        )) {
            Text("Text")
        }
    }

}
