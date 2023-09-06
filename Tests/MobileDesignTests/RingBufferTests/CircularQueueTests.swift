//
// CircularQueueTests.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import XCTest
@testable import MobileDesign
@testable import CircularBuffer
import Foundation
import AVKit
final class RingBufferTests: XCTestCase {

    func testSize() throws {

        let size = 10
        let buffer = CircularBuffer(size: size, initValue: 0.0)
        XCTAssertEqual(buffer.size, size)

    }

    func testIndex() throws {

        let size = 10
        let buffer = CircularBuffer(size: size, initValue: 0.0)

        for i in 0..<25 {
            XCTAssertEqual(buffer.index, i % size)
            buffer.push(0.0)
        }

    }

    func testSubscription() throws {

        let size = 10
        let buffer = CircularBuffer(size: size, initValue: 0.0)

        (1...25).forEach { buffer.push(Double($0)) }

        XCTAssertEqual(buffer[-10], 16.0)
        XCTAssertEqual(buffer[-5],  21.0)
        XCTAssertEqual(buffer[-2],  24.0)
        XCTAssertEqual(buffer[-1],  25.0)
        XCTAssertEqual(buffer[0],   16.0)
        XCTAssertEqual(buffer[1],   17.0)
        XCTAssertEqual(buffer[2],   18.0)
        XCTAssertEqual(buffer[5],   21.0)
        XCTAssertEqual(buffer[10],  16.0)

    }

    func testIsFilled() throws {

        let size = 10
        let buffer = CircularBuffer(size: size, initValue: 0.0)

        for i in 0..<25 {

            if i < size {
                XCTAssertEqual(buffer.isFilled, false)
            }
            else {
                XCTAssertEqual(buffer.isFilled, true)
            }
            buffer.push(0.0)
        }

    }

    func testGetBuffer() throws {

        let size = 10
        let buffer = CircularBuffer(size: size, initValue: 0.0)

        (1...5).forEach { buffer.push(Double($0)) }
        XCTAssertEqual(buffer.getBuffer(), [1.0, 2.0, 3.0, 4.0, 5.0, 0.0, 0.0, 0.0, 0.0, 0.0])

        (6...15).forEach { buffer.push(Double($0)) }
        XCTAssertEqual(buffer.getBuffer(), [11.0, 12.0, 13.0, 14.0, 15.0, 6.0, 7.0, 8.0, 9.0, 10.0])

    }

    func testGetAligned() throws {

        let size = 10
        let buffer = CircularBuffer(size: size, initValue: 0.0)

        (1...5).forEach { buffer.push(Double($0)) }
        XCTAssertEqual(buffer.getAligned(), [0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 2.0, 3.0, 4.0, 5.0])

        (6...15).forEach { buffer.push(Double($0)) }
        XCTAssertEqual(buffer.getAligned(), [6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0])

    }

    func testAVPlayer() {
        measure(metrics: [XCTMemoryMetric()]) { // to measeure RAM consuming
            let buffer = CircularBuffer<AVPlayer?>(size: 3, initValue: nil)
            (1...100).forEach { _ in
                buffer.push(
                    AVPlayer(url: URL(string: "https://www.pexels.com/download/video/5913482/")!)
                )
                print(buffer.size)
            }
        }

    }

}
