//
// CircularQueueTests.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import XCTest
@testable import MobileDesign
import CircularBuffer
final class RingBufferTests: XCTestCase {


    func test_basic_read_and_write() throws {
        var buffer = CircularBuffer<Int>(initialCapacity: 3)

        buffer.prependWithoutExpanding(123)
        buffer.prependWithoutExpanding(456)
        buffer.prependWithoutExpanding(789)
        buffer.prependWithoutExpanding(666)

        XCTAssertEqual(Array(buffer), [123, 456, 789])

        buffer.prependWithoutExpanding(333)
        buffer.prependWithoutExpanding(555)

//        XCTAssertEqual(buffer[offset: 0], 666)
//        XCTAssertEqual(buffer[offset: 1], 333)
//        XCTAssertEqual(buffer[offset: 2], 555)
    }

}
