//
//  VideoControlProgressView.swift
//
//
//  Created by James Kong on 6/1/2024.
//

import SwiftUI

public struct VideoControlProgressView: View {

    @Binding public var sliderValue: Double
    let total: Double
    let colors: any NMGThemeableColors
    let handleHeight: CGFloat = 20
    @State var isTracking = false
    var onChanged: ((Double) -> Void)?
    var onEnded: ((Double) -> Void)?

    public init(
        sliderValue: Binding<Double>
        , total: Double
        , theme: any NMGThemeable = ThemeManager.shared.currentTheme
        , onChanged: ((Double) -> Void)? = nil
        , onEnded: ((Double) -> Void)? = nil
    ) {
        self.colors = theme.colors
        self._sliderValue = sliderValue
        self.total = total
        self.onChanged = onChanged
        self.onEnded = onEnded
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                ProgressView(value: sliderValue, total: total)
                    .tint(colors.primaryMain.color)
                    .background(Color.white)
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(colors.primaryMain.color)
                    .frame(width: handleHeight, height: handleHeight)
                    .position(x: (sliderValue / total) * geometry.size.width, y: geometry.size.height / 2)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({
                        isTracking = true
                        sliderValue = (min(geometry.size.width, max(0, $0.location.x)) / geometry.size.width) * total
                        onChanged?(sliderValue/total)
                    })
                    .onEnded({ _ in
                        isTracking = false
                        onEnded?(sliderValue)
                    })
            )
        }
    }
}

struct VideoControlProgressViewPreview: View {

    @State var sliderValue: Double = 0.5
    var body: some View {
        VideoControlProgressView(sliderValue: $sliderValue, total: 1)
    }
}

#Preview {
    VideoControlProgressViewPreview()
}
