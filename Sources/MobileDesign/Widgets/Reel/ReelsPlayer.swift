//
// ReelsPlayer.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import AVKit
import ExpandableText

public struct ReelPlayer<Reel>: View where Reel: ReelDataProtocol {
    @Binding var reel: Reel

    @Binding var currentReelID: String
    let theme: NMGThemeable = ThemeManager.shared.currentTheme

    public init(reel: Binding<Reel>, currentReelID: Binding<String>) {
        self._reel = reel
        self._currentReelID = currentReelID
    }

    public var body: some View {

        ZStack {

            if let player = reel.player {

                CustomVideoPlayer(player: player)

                GeometryReader { proxy in
                    self.useProxy(reel, player, proxy)
                }

                Color.black
                    .opacity(0.01)
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        // todo: video player paused
                    }

                VStack {

                    HStack(alignment: .bottom) {

                        VStack(alignment: .leading, spacing: 10) {

                            Text(reel.mediaFile.title)
                                .font(.callout.bold())
                                .foregroundColor(theme.colors.neutralGray2.color)

                            ExpandableText(text: reel.mediaFile.content)
                                .font(.body)
                                .foregroundColor(theme.colors.neutralGray2.color)
                                .lineLimit(2)
                                .expandButton(TextSet(text: "展開", font: .body, color: theme.colors.neutralGray60.color))
                                .expandAnimation(.easeOut)
                        }

                        Spacer(minLength: 20)

                        ReelActionButtonGroup()
                            .padding([.bottom], 40)

                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .foregroundColor(Color.white)
                .frame(maxHeight: .infinity, alignment: .bottom)

            }

        }

    }

    func useProxy(_ reel: Reel, _ player: AVPlayer, _ proxy: GeometryProxy) -> some View {
        let minY = proxy.frame(in: .global).minY

        let size = proxy.size

        DispatchQueue.main.async {

            if -minY < (size.height / 2) && minY < (size.height / 2) && currentReelID == reel.id {

                player.play()
            } else {
                player.pause()
            }
        }

        return VStack {
            Color.clear
        }
    }
}
