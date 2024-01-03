//
// ColorPaletteTests.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import MobileDesign

final class ColorPaletteTests: XCTestCase {
  override func setUpWithError() throws {
  }

  func test_color_Common_snapshot() {
    let colors = WWColors().common()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      //            assertSnapshot(matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }

  func test_color_ED_snapshot() {
    let colors = EDColors().properties()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }

  func test_color_WW_snapshot() {
    let colors = WWColors().properties()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }

  func test_color_MORE_snapshot() {
    let colors = MOREColors().properties()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }

  func test_color_KISS_snapshot() {
    let colors = KISSColors().properties()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }

  func test_color_GOTRIP_snapshot() {
    let colors = GOTRIPColors().properties()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }

  func test_color_OS_snapshot() {
    let colors = OSColors().properties()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }

  func test_color_NM_snapshot() {
    let colors = NMColors().properties()

    Array(colors.keys).sorted { a, b in
      a < b
    }.forEach { key in
      let vc = UIHostingController(rootView: ColorItem(key: key, color: colors[key]))
      guard let view = vc.view else { fatalError() }
      vc.overrideUserInterfaceStyle = .dark
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) dark")
      vc.overrideUserInterfaceStyle = .light
      assertSnapshot(
        matching: vc, as: .image(size: CGSize(width: 256, height: 256)), named: "\(key) light")
    }
  }
}
