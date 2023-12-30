//
//  VideoPlayerControlInitViewTest.swift
//
//
//  Created by James Kong on 30/12/2023.
//

import XCTest
@testable import MobileDesign
import SwiftUI
import SnapshotTesting

final class VideoPlayerOverlayViewTest: XCTestCase {

    override func setUpWithError() throws {
        isRecording = true
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_snapshot_default() throws {
        let theme = ThemeManager.shared.currentTheme
        let data = MockVideoDisplayable(
            imageURL: "https://placehold.co/1920x1080/png",
            headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
            leadingFootnote: "4小時前",
            secondFootnote: "經人觀點",
            id: 1, url: "", videoType: "")
        let rootView = VStack {
                VideoPlayerOverlayView(
                    data: data,
                    state: .LOADING) {
                        UpcomingVideoView(item: data, isFinish: .constant(false)) {

                        } nextVideoAction: {

                        }

                    }
                    .aspectRatio(16 / 9, contentMode: .fit)

                VideoPlayerOverlayView(
                    data: data,
                    state: .COMPLETED) {
                        UpcomingVideoView(item: data, isFinish: .constant(true)) {

                        } nextVideoAction: {

                        }

                    }.aspectRatio(16 / 9, contentMode: .fit)
            }

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
