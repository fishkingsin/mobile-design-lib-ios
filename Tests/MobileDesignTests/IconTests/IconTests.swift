//
//  IconTests.swift
//
//
//  Created by James Kong on 30/12/2023.
//

import XCTest
@testable import MobileDesign
import SwiftUI
import SnapshotTesting

final class IconTests: XCTestCase {

    override func setUpWithError() throws {
//        isRecording = true
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_snapshot_all_icons() throws {
        let theme = ThemeManager.shared.currentTheme
        let rootView = LazyVGrid(columns: [GridItem(.fixed(60)), GridItem(.fixed(60)), GridItem(.fixed(60))], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            ForEach([
                theme.icons.warnning,
                theme.icons.exclamationmarkCircle,
                theme.icons.heart,
                theme.icons.heartFill,
                theme.icons.arrowUpFromSquare,
                theme.icons.naviTVIcon,
                theme.icons.tabIconTVSelected,
                theme.icons.tabIconTV,
                theme.icons.videoDetailLanding,
                theme.icons.circlePlay,
                theme.icons.circleLoading,
                theme.icons.circlePause,
                theme.icons.circleReplay,
                theme.icons.circleArrowLeftToLine,
                theme.icons.circleArrowRightToLine
            ], id: \.self) { image in
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 50, height: 50)
                        .padding(5)
                        .border(Color.gray, width: 5)
                    Image(uiImage: image)
                        .tint(.black)

                }
            }

        })
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
