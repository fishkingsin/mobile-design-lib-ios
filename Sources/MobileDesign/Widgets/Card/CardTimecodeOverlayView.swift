//
// CardTimecodeOverlayView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct CardTimecodeOverlayView: View {
    var timecode: String
    var backgroundColor = ThemeManager.shared.currentTheme.colors.neutralGray50.color
    var foregroundColor = ThemeManager.shared.currentTheme.colors.white.color
    var body: some View {
        HStack(alignment: .center, spacing: 2) {
            Image("Play", bundle: .module)
                .frame(width: 8.48485, height: 10)
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
            Text(timecode)
                .font(ThemeManager.shared.currentTheme.fonts.eleRegular12.uiFont)
                .kerning(0.3)
                .multilineTextAlignment(.center)
                .foregroundColor(foregroundColor)
        }
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(backgroundColor)
            .cornerRadius(4)
    }
}

struct CardTimecodeOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        CardTimecodeOverlayView(timecode: "22:22")
    }
}
