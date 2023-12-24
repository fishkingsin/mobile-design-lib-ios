//
//  ScrollviewWithStickyHeader.swift
//  MobileDesignSampleApp
//
//  Created by James Kong on 23/12/2023.
//

import SwiftUI
import MobileDesign
import ScrollKit
struct ScrollviewWithStickyHeader<HeaderView: View>: View {
    let headerHeight: CGFloat

    @ViewBuilder
    let headerView: () -> HeaderView

    @State
    private var headerVisibleRatio: CGFloat = 1

    @State
    private var scrollOffset: CGPoint = .zero

    var body: some View {
        VStack {
            Color.red.frame(width: .infinity, height: 240)
            ScrollViewWithStickyHeader(
                header: header,
                headerHeight: headerHeight,
                onScroll: handleScrollOffset
            ) {
                listItems
            }.padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
        }
    }

    @State private var favoriteColor = 0

    func header() -> some View {
        ZStack(alignment: .bottomLeading) {
            headerView()
            VStack {
                headerTitle
                Picker("What is your favorite color?", selection: $favoriteColor) {
                    Text("Red").tag(0)
                    Text("Green").tag(1)
                    Text("Blue").tag(2)
                }
                .pickerStyle(.segmented)

            }
        }
    }

    var headerTitle: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Demo Title").font(.largeTitle)
            Text("Some additional information")
        }
        .padding(20)
        .opacity(headerVisibleRatio)
    }

    var listItems: some View {
        VStack {

            LazyVStack(spacing: 0) {
                ForEach(1...100, id: \.self) { item in
                    VStack(spacing: 0) {
                        Text("Item \(item)")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                    }
                }
            }
        }
    }

    func handleScrollOffset(_ offset: CGPoint, headerVisibleRatio: CGFloat) {
        self.scrollOffset = offset
        self.headerVisibleRatio = headerVisibleRatio
    }
}

private func headerView() -> some View {
    ScrollViewHeaderImage(Image("header"))
}

#Preview {
    NavigationView {
        ScrollviewWithStickyHeader(
            headerHeight: 250,
            headerView: headerView
        )
    }
}

private extension View {

    func previewHeaderContent() -> some View {
        self.foregroundColor(.white)
            .shadow(color: .black.opacity(0.4), radius: 1, x: 1, y: 1)
    }
}
