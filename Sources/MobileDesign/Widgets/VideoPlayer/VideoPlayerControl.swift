//
//  SwiftUIView.swift
//  
//
//  Created by James Kong on 31/12/2023.
//

import SwiftUI

public protocol VideoPlayerControlable: View {
    var onLeadingIconClick: (() -> Void)? { get }
    var onCenterIconClick: (() -> Void) { get }
    var onTrailingIconClick: (() -> Void)? { get }
}

public struct VideoPlayerControl: VideoPlayerControlable {
    @ObservedObject var model: PlaybackStateModel

    let theme: any NMGThemeable
    let icons: any NMGThemeableIcons

    public var onLeadingIconClick: (() -> Void)?
    public var onCenterIconClick: (() -> Void)
    public var onTrailingIconClick: (() -> Void)?

    public init(
        model: PlaybackStateModel,
        theme: any NMGThemeable = ThemeManager.shared.currentTheme,
        onCenterIconClick: @escaping (() -> Void),
        onLeadingIconClick: (() -> Void)? = nil,
        onTrailingIconClick: (() -> Void)? = nil) {
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
                if let onLeadingIconClick = onLeadingIconClick {
                    Button {
                        onLeadingIconClick()
                    } label: {
                        Image(uiImage: leadingIcon)
                    }
                }

                Button {
                    onCenterIconClick()
                } label: {
                    Image(uiImage: centerIcon)
                }
                if let onTrailingIconClick = onTrailingIconClick {
                    Button {
                        onTrailingIconClick()
                    } label: {
                        Image(uiImage: trailingIcon)
                    }
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

    } onLeadingIconClick: {

    } onTrailingIconClick: {

    }

}
