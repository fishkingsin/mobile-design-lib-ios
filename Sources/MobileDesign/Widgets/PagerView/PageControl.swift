//
// PageControl.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct PageControl: View {

    @Binding var selectedPage: Int

    var pages: Int
    var circleDiameter: CGFloat
    var circleMargin: CGFloat

    public init(selectedPage: Binding<Int>, pages: Int, circleDiameter: CGFloat, circleMargin: CGFloat) {
        self._selectedPage = selectedPage
        self.pages = pages
        self.circleDiameter = circleDiameter
        self.circleMargin = circleMargin
    }

    public var body: some View {
        ZStack {
            // Total number of pages
            HStack(spacing: circleMargin) {
                ForEach(0 ..< pages) { _ in
                    Circle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: circleDiameter, height: circleDiameter)
                }
            }

            // Current page index
            Circle()
                .fill(Color.white)
                .frame(width: circleDiameter, height: circleDiameter)
                .offset(x: currentPosition).animation(.linear(duration: 0.3))
        }
    }

    private var circleRadius: CGFloat { circleDiameter / 2}
    private var pageIndex: CGFloat { CGFloat(selectedPage - 1) }

    private var currentPosition: CGFloat {
        // Get the first circle position
        let stackWidth = circleDiameter * CGFloat(pages) + circleMargin * CGFloat(pages - 1)
        let halfStackWidth = stackWidth / 2
        let iniPosition = -halfStackWidth + circleRadius

        // Calculate the distance to get the next circle
        let distanceToNextPoint = circleDiameter + circleMargin

        // Use the pageIndex to get the current position
        return iniPosition + (pageIndex * distanceToNextPoint)
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle().fill(Color(ThemeManager.shared.currentTheme.colors.primaryMain))
            PageControl(selectedPage: .constant(1),
                        pages: 3,
                        circleDiameter: 5,
                        circleMargin: 6)
        }
    }
}
