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
        isRecording = true
    }

    override func tearDownWithError() throws {
    }

    func test_horizontal_card_snapshot_short() throws {
        let rootView = sut(start: 1, end: 10)
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

    func test_horizontal_card_snapshot_medium() throws {
        let rootView = sut(start: 20, end: 50)
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

    func test_horizontal_card_snapshot_long() throws {
        let rootView = sut(start: 50, end: 100)
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

    func sut(start: Int, end: Int) -> some View {
        List(stride(from: start, to: end, by: 1).map { i in
            CardData(
                imageURL: "\(i)",
                headline: "HKTVmall 2.0 ？拆解友和申請上市之謎 一年收入5億 ？｜抽新股｜IPO｜ 日本城｜ 港股｜王維基【經一解密】 經濟一週 EDigest HKTVmall 2.0 ？拆解友和申請上市之謎 一年收入5億 ？｜抽新股｜IPO｜ 日本城｜ 港股｜王維基【經一解密】 經濟一週 EDigest HKTVmall 2.0 ？拆解友和申請上市之謎 一年收入5億 ？｜抽新股｜IPO｜ 日本城｜ 港股｜王維基【經一解密】 經濟一週 EDigest".substring(start: 0, end: i),
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點"
            )
        }) { data in

            HorizontalCard(data: data) {
                if !data.imageURL.contains("\(start + 3)") {
                    EmptyView()
                } else {
                    ZStack {
                        Rectangle()
                            .opacity(0.3)
                            .foregroundStyle(.black)
                        Text("正在播放").foregroundStyle(.white)
                    }
                }
            }

            .listRowSeparator(.hidden)
            .background( data.imageURL.contains("\(start + 3)") ? .black.opacity(0.1) : .clear)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listRowInsets(.none)
        .listStyle(.plain)
    }

}

extension String {
    func substring(start: Int, end : Int) -> Self
    {
        let str = self
        let startIndex = str.index(str.startIndex, offsetBy: start)
        let endIndex = str.index(str.startIndex, offsetBy: end)
        return String(str[startIndex..<endIndex])
    }
}
