//
// TrackableScrollView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct TrackableScrollView<Content>: View where Content: View {
    let axes: Axis.Set
    let showIndicators: Bool
    @Binding var contentOffset: CGFloat
    let content: Content

    /// Creates a new instance that’s scrollable in the direction of the given axis and can show indicators while scrolling.
    /// - Parameters:
    ///   - axes: The scrollable axes of the scroll view.
    ///   - showIndicators: A value that indicates whether the scroll view displays the scrollable component of the content offset, in a way that’s suitable for the platform.
    ///   - contentOffset: A value that indicates  offset of content.
    ///   - content: The scroll view’s content.
    public init(_ axes: Axis.Set = .vertical, showIndicators: Bool = true, contentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showIndicators = showIndicators
        _contentOffset = contentOffset
        self.content = content()
    }

    public var body: some View {
        GeometryReader { outsideProxy in
            ScrollView(self.axes, showsIndicators: self.showIndicators) {
                ZStack(alignment: self.axes == .vertical ? .top : .leading) {
                    GeometryReader { insideProxy in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
                    }
                    VStack {
                        self.content
                    }
                }
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.contentOffset = value[0]
            }
        }
    }

    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        if axes == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
        }
    }
}

struct TrackableScrollViewDemo: View {
    @State var offset: CGFloat = .zero
    var body: some View {
        VStack {
            Text("\(offset)")
            HStack {
                TrackableScrollView(contentOffset: $offset) {
                    VStack {

                        ForEach(0...10, id: \.self) { rowIndex in

                            TimelineRowView()
                        }
                    }
                }
                TrackableScrollView(contentOffset: $offset) {
                    VStack {

                        ForEach(0...10, id: \.self) { rowIndex in

                            TimelineRowView()
                        }
                    }
                }
            }
        }
    }
}
struct TimelineRowView: View {


    var body: some View {

        HStack {

            ForEach(0...4, id: \.self) { itemIndex in

                TimelineCellView()
            }
        }
    }
}

struct TimelineCellView: View {


    var body: some View {

        Rectangle()
            .fill(Color.yellow)
            .aspectRatio(1.0, contentMode: .fit)

    }
}

struct TrackableScrollViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        TrackableScrollViewDemo()
    }
}
