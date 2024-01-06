//
//  VideoPlayerControlTests.swift
//
//
//  Created by James Kong on 31/12/2023.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign

final class VideoPlayerControlTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_snapshot() {
        VideoPlayerControlState.allCases.forEach { state in
            let rootView = VStack {
                VideoPlayerControl(model: PlaybackStateModel(playbackState: state)) {

                } onLeadingIconClick: {

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

            wait(for: [expectation], timeout: 2)
        }
    }

    func test__avplayer_video_controler_snapshot() {

        VideoPlayerControlState.allCases.forEach { state in
            let playbackStateModel = PlaybackStateModel(playbackState: state)
            let rootView = VStack {
                ZStack(alignment: .bottom) {

                    VideoPlayerControl(
                        model: playbackStateModel
                    ) {


                    } onLeadingIconClick: {

                    } onTrailingIconClick: {

                    } onRightBottomIconClick: {

                    }
                    .opacity(1.0)

                    VStack() {
                        Spacer().layoutPriority(1)
                        VideoControlProgressView(
                            sliderValue: .constant(0.5),
                            total: 1.0
                        )
                        { _ in } onEnded: { _ in }
                    }
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

            wait(for: [expectation], timeout: 2)
        }
    }

}
