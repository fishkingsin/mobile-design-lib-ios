//
//  SwiftUIView.swift
//  
//
//  Created by James Kong on 22/12/2023.
//

import SwiftUI

public struct ScrollViewWithOffset<Content: View>: View {

    public init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.onScroll = onScroll ?? { _ in }
        self.content = content
    }

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let onScroll: ScrollAction
    private let content: () -> Content

    public typealias ScrollAction = (_ offset: CGPoint) -> Void

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            ZStack(alignment: .top) {
                ScrollViewOffsetTracker()
                content()
            }
        }.withOffsetTracking(action: onScroll)
    }
}

private extension ScrollView {

    func withOffsetTracking(
        action: @escaping (_ offset: CGPoint) -> Void
    ) -> some View {
        self.coordinateSpace(name: ScrollOffsetNamespace.namespace)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
    }
}

