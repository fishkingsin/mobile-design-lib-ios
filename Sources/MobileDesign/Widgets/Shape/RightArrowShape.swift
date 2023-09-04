//
// RightArrowShape.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct RightArrowShape: Shape {
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.81201*width, y: 0.06575*height))
        path.addCurve(to: CGPoint(x: 0.78277*width, y: 0.02289*height), control1: CGPoint(x: 0.80466*width, y: 0.04748*height), control2: CGPoint(x: 0.79458*width, y: 0.03271*height))
        path.addCurve(to: CGPoint(x: 0.74466*width, y: 0.00975*height), control1: CGPoint(x: 0.77097*width, y: 0.01307*height), control2: CGPoint(x: 0.75783*width, y: 0.00855*height))
        path.addLine(to: CGPoint(x: 0.11735*width, y: 0.00975*height))
        path.addCurve(to: CGPoint(x: 0.05785*width, y: 0.05083*height), control1: CGPoint(x: 0.09504*width, y: 0.00975*height), control2: CGPoint(x: 0.07363*width, y: 0.02453*height))
        path.addCurve(to: CGPoint(x: 0.0332*width, y: 0.15*height), control1: CGPoint(x: 0.04207*width, y: 0.07713*height), control2: CGPoint(x: 0.0332*width, y: 0.11281*height))
        path.addLine(to: CGPoint(x: 0.0332*width, y: 0.85*height))
        path.addCurve(to: CGPoint(x: 0.05796*width, y: 0.94885*height), control1: CGPoint(x: 0.03328*width, y: 0.88712*height), control2: CGPoint(x: 0.04218*width, y: 0.92266*height))
        path.addCurve(to: CGPoint(x: 0.11735*width, y: 0.98975*height), control1: CGPoint(x: 0.07373*width, y: 0.97504*height), control2: CGPoint(x: 0.09509*width, y: 0.98975*height))
        path.addLine(to: CGPoint(x: 0.74466*width, y: 0.98975*height))
        path.addCurve(to: CGPoint(x: 0.78277*width, y: 0.97662*height), control1: CGPoint(x: 0.75783*width, y: 0.99096*height), control2: CGPoint(x: 0.77097*width, y: 0.98643*height))
        path.addCurve(to: CGPoint(x: 0.81201*width, y: 0.93375*height), control1: CGPoint(x: 0.79458*width, y: 0.96679*height), control2: CGPoint(x: 0.80466*width, y: 0.95203*height))
        path.addLine(to: CGPoint(x: 0.9968*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.81201*width, y: 0.06575*height))
        path.closeSubpath()
        return path
    }
}

public struct RightArrowShapeWithTextViewStyle: ViewModifier {
    let color: Color
    public init(color: Color) {
        self.color = color
    }
    public func body(content: Content) -> some View {
        content
            .foregroundColor(color)

    }
}

public struct RightArrowShapeWithTextView: View {
    
    let text: String
    let modifier: RightArrowShapeWithTextViewStyle
    let theme: NMGThemeable

    public init(text: String, modifier: RightArrowShapeWithTextViewStyle, theme: NMGThemeable = ThemeManager.shared.currentTheme) {
        self.text = text
        self.modifier = modifier
        self.theme = theme
    }

    public var body: some View {
        ZStack {
            RightArrowShape().frame(width: caluateSize(), height: 15).modifier(modifier)
            Text(text)
                .font(Font(theme.fonts.caption3Emphasize))
                .foregroundColor(.white)
        }
    }
    
    private func caluateSize() -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 15)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: theme.fonts.caption3Emphasize], context: nil)
        return ceil(boundingBox.width) + 10
    }
}

struct RightArrowShapeView_Previews: PreviewProvider {
    static var previews: some View {
        RightArrowShapeWithTextView(text: "HK", modifier: RightArrowShapeWithTextViewStyle(color: .red))
    }
}
