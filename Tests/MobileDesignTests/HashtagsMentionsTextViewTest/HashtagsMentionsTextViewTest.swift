//
//  HashtagsMentionsTextViewTest.swift
//  
//
//  Created by James Kong on 27/12/2023.
//

import XCTest
@testable import MobileDesign
import SwiftUI
import SnapshotTesting

final class HashtagsMentionsTextViewTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let rootView = HashtagsMentionsTextViewPreview()
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

}
