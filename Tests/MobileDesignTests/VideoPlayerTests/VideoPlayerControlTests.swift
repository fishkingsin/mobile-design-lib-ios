//
//  VideoPlayerControlTests.swift
//  
//
//  Created by James Kong on 31/12/2023.
//

import XCTest
@testable import MobileDesign
import SwiftUI
import SnapshotTesting

final class VideoPlayerControlTests: XCTestCase {

    override func setUpWithError() throws {
        isRecording = true
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_snapshot() {
        VideoPlayerControlState.allCases.forEach{ state in
            let rootView = VStack {
                VideoPlayerControl(model: PlaybackStateModel(playbackState: state)) {

                } onCenterIconClick: {

                } onTrailingIconClick: {

                }

            }

            let vc = UIHostingController(rootView: rootView)
            vc.overrideUserInterfaceStyle = .light
            let expectation = expectation(description: "loading image")
            vc.viewDidLoad()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let view = vc.view {
                    assertSnapshot(matching: vc, as: .image(on: .iPhone13Pro), named: state.rawValue)
                } else {
                    XCTFail("view not found")
                }
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 1)
        }
    }

}
