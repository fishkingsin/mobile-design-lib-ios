//
//  SwiftUIView.swift
//  
//
//  Created by James Kong on 31/12/2023.
//

import SwiftUI

public struct VideoPlayerControl: View {
    @ObservedObject var model: PlaybackStateModel
    
    let theme: any NMGThemeable
    let icons: any NMGThemeableIcons

    let onLeadingIconClick: () -> Void
    let onCenterIconClick: () -> Void
    let onTrailingIconClick: () -> Void

    public init(
        model: PlaybackStateModel,
        theme: any NMGThemeable = ThemeManager.shared.currentTheme,
        onLeadingIconClick: @escaping () -> Void,
        onCenterIconClick: @escaping () -> Void,
        onTrailingIconClick: @escaping () -> Void) {
        self.model = model
        self.theme = theme
        self.icons = theme.icons
        self.onLeadingIconClick = onLeadingIconClick
        self.onCenterIconClick = onCenterIconClick
        self.onTrailingIconClick = onTrailingIconClick
    }
    public var body: some View {
        ZStack(alignment: .center) {
            HStack(spacing: 32) {
                Spacer()
                Button {
                    onLeadingIconClick()
                } label: {
                    Image(uiImage: leadingIcon)
                }

                Button {
                    onCenterIconClick()
                } label: {
                    Image(uiImage: centerIcon)
                }

                Button {
                    onTrailingIconClick()
                } label: {
                    Image(uiImage: trailingIcon)
                }
                Spacer()
            }
        }
    }

    var leadingIcon: UIImage {
        switch model.playbackState {
            case .INIT, .UNKNOWN, .ERROR:
                return UIImage()
            default:
                return icons.circleArrowLeftToLine
        }
    }

    var centerIcon: UIImage {
        switch model.playbackState {
            case .REPLAY, .COMPLETED:
                return icons.circleReplay
            case .PLAYING:
                return icons.circlePause
            case .PAUSED, .READY:
                return icons.circlePlay
            default:
                return icons.circleLoading
        }
    }

    var trailingIcon: UIImage {
        switch model.playbackState {
            case .INIT, .UNKNOWN, .ERROR:
                return UIImage()
            default:
                return icons.circleArrowRightToLine
        }
    }
}

#Preview {
    VideoPlayerControl(model: PlaybackStateModel(playbackState: .READY)) {

    } onCenterIconClick: {

    } onTrailingIconClick: {

    }

}
