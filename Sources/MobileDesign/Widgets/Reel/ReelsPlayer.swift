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

    @Binding var currentReel: String
    let theme: NMGThemeable = ThemeManager.shared.currentTheme

    public init(reel: Binding<Reel>, currentReel: Binding<String>) {
        self._reel = reel
        self._currentReel = currentReel
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

                            Text("@經一速遞")
                                .font(.callout.bold())
                                .foregroundColor(Color.white)

                            ExpandableText(text: "若從每人身上賺1元大餅，已是14個億的大茶飯")
                                .font(.body)
                                .foregroundColor(.primary)
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

            if -minY < (size.height / 2) && minY < (size.height / 2) && currentReel == reel.id {

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

public var MediaFileJSON = [
    MediaFile(url: "Reel-1", title: "Fantastic mountains"),
    MediaFile(url: "Reel-2", title: "Work Work Work!"),
    MediaFile(url: "Reel-3", title: "Gorgeous City")
]
