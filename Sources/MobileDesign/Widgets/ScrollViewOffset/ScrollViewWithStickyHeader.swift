//
//  SwiftUIView.swift
//
//
//  Created by James Kong on 22/12/2023.
//

import SwiftUI

public struct ScrollViewWithStickyHeader<Header: View, Content: View>: View {

  public init(
    _ axes: Axis.Set = .vertical,
    @ViewBuilder header: @escaping () -> Header,
    headerHeight: CGFloat,
    headerMinHeight: CGFloat? = nil,
    showsIndicators: Bool = true,
    onScroll: ScrollAction? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.axes = axes
    self.showsIndicators = showsIndicators
    self.header = header
    self.headerHeight = headerHeight
    self.headerMinHeight = headerMinHeight
    self.onScroll = onScroll
    self.content = content
  }

  private let axes: Axis.Set
  private let showsIndicators: Bool
  private let header: () -> Header
  private let headerHeight: CGFloat
  private let headerMinHeight: CGFloat?
  private let onScroll: ScrollAction?
  private let content: () -> Content

  public typealias ScrollAction = (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

  @State
  private var navigationBarHeight: CGFloat = 0

  @State
  private var scrollOffset: CGPoint = .zero

  private var headerVisibleRatio: CGFloat {
    max(0, (headerHeight + scrollOffset.y) / headerHeight)
  }

  public var body: some View {
    ZStack(alignment: .top) {
      scrollView
      navbarOverlay
    }
    .prefersNavigationBarHidden()
    #if os(iOS)
      .navigationBarTitleDisplayMode(.inline)
    #endif
  }
}

extension View {

  @ViewBuilder
  fileprivate func prefersNavigationBarHidden() -> some View {
    #if os(iOS) || os(macOS)
      if #available(iOS 16.0, macOS 13.0, *) {
        self.toolbarBackground(.hidden)
      } else {
        self
      }
    #else
      self
    #endif
  }
}

extension ScrollViewWithStickyHeader {

  fileprivate var headerView: some View {
    header().frame(height: headerHeight)
  }

  @ViewBuilder
  fileprivate var navbarOverlay: some View {
    if headerVisibleRatio <= 0 {
      Color.clear
        .frame(height: navigationBarHeight)
        .overlay(scrollHeader, alignment: .bottom)
        .ignoresSafeArea(edges: .top)
    }
  }

  fileprivate var scrollView: some View {
    GeometryReader { proxy in
      ScrollViewWithOffset(onScroll: handleScrollOffset) {
        VStack(spacing: 0) {
          scrollHeader
          content()
        }
      }
      .onAppear {
        DispatchQueue.main.async {
          navigationBarHeight = proxy.safeAreaInsets.top
        }
      }
    }
  }

  fileprivate var scrollHeader: some View {
    ScrollViewHeader(content: header)
      .frame(height: headerHeight)
  }

  fileprivate func handleScrollOffset(_ offset: CGPoint) {
    self.scrollOffset = offset
    self.onScroll?(offset, headerVisibleRatio)
  }
}
