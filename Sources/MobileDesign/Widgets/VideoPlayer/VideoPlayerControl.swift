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

    let icons: any NMGThemeableIcons
    let colors: any NMGThemeableColors

    public var onLeadingIconClick: (() -> Void)?
    public var onCenterIconClick: (() -> Void)
    public var onTrailingIconClick: (() -> Void)?
    public var onRightBottomIconClick: (() -> Void)?
    
//    @Binding private var sliderValue: TimeInterval
//    let total: CGFloat

    public init(
        model: PlaybackStateModel,
//        currentTime: Binding<TimeInterval>,
//        total: CGFloat,
        theme: any NMGThemeable = ThemeManager.shared.currentTheme,
        onCenterIconClick: @escaping (() -> Void),
        onLeadingIconClick: (() -> Void)? = nil,
        onTrailingIconClick: (() -> Void)? = nil,
        onRightBottomIconClick: (() -> Void)? = nil) {
            self.model = model
//            self._sliderValue = currentTime
//            self.total = total

            self.icons = theme.icons
            self.colors = theme.colors
            self.onLeadingIconClick = onLeadingIconClick
            self.onCenterIconClick = onCenterIconClick
            self.onTrailingIconClick = onTrailingIconClick
            self.onRightBottomIconClick = onRightBottomIconClick
        }
    public var body: some View {
        ZStack {
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
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    if let onRightBottomIconClick = onRightBottomIconClick {
                        Button {
                            onRightBottomIconClick()
                        } label: {
                            Image(uiImage: icons.expand)
                                .shadow(radius: 10)
                        }

                    }
                    
                }

                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
            }

            

        }.overlay {

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
    VideoPlayerControl(
        model: PlaybackStateModel(playbackState: .READY)
//        ,
//        currentTime: .constant(50),
//        total: 100
    ) {

    } onLeadingIconClick: {

    } onTrailingIconClick: {

    } onRightBottomIconClick: {

    }
    .frame(width: .infinity)
    .aspectRatio( 16 / 9, contentMode: .fit)
    .background(Color.gray)

}
