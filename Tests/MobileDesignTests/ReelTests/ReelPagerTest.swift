//
//  ReelPagerTest.swift
//  
//
//  Created by James Kong on 10/9/2023.
//

import XCTest
@testable import MobileDesign
import SwiftUI
import SnapshotTesting

final class ReelPagerTest: XCTestCase {

    override func setUpWithError() throws {
        isRecording = true
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
        ReelsPager(currentReel: reels.first!.id, reels: reels)
    }

}
