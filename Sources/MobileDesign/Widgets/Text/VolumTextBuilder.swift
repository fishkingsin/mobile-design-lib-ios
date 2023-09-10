//
// VolumTextBuilder.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct VolumTextModifier: ViewModifier {
    let color: Color
    public init(color: Color) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .foregroundColor(color)
    }
}

public struct VolumTextBuilder: View {
    let theme: NMGThemeable
    let titlePrefix: String
    let titleSuffix: String?
    let subtitle: String?
    let modifier: VolumTextModifier

    public init(titlePrefix: String, titleSuffix: String? = nil, subtitle: String? = nil, modifier: VolumTextModifier, theme: NMGThemeable = ThemeManager.shared.currentTheme) {
        self.theme = theme
        self.titlePrefix = titlePrefix
        self.titleSuffix = titleSuffix
        self.subtitle = subtitle
        self.modifier = modifier
    }

    public var body: some View {
        VStack {
            VStack {
                if let titleSuffix = titleSuffix {
                    {
                        Text(titlePrefix)
                            .font(Font(theme.fonts.futuraCondenseExtraBold))
                            .foregroundColor(modifier.color)
                        +
                        Text(titleSuffix)
                            .font(Font(theme.fonts.futuraCondenseBold))
                            .foregroundColor(modifier.color)
                    }()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                } else {
                    Text(titlePrefix)
                        .font(Font(theme.fonts.futuraCondenseExtraBold))
                        .foregroundColor(modifier.color)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
            }
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(Font(theme.fonts.title5))
                    .foregroundColor(theme.colors.primaryMain.color)
            }
        }
    }
}

struct VolumTextBuilder_Previews: PreviewProvider {
    static var previews: some View {
        VolumTextBuilder(titlePrefix: "+18.50%", modifier: VolumTextModifier(color: .green))
    }
}

struct VolumTextBuilder_2_Previews: PreviewProvider {
    static var previews: some View {
        VolumTextBuilder(titlePrefix: "1234899837393899877393838", titleSuffix: ".56", subtitle: "HKD", modifier: VolumTextModifier(color: .green))
    }
}
