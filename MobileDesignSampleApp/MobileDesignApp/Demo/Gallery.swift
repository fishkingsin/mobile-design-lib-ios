//
// Gallery.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

// import SwiftUI
import MobileDesign
import AVKit
import SwiftUI

struct VimeoPreview: View {
    @State var playbackStateModel = PlaybackStateModel(playbackState: .INIT)
    var body: some View {
        TVPOC(url: "https://player.vimeo.com/external/831404478.m3u8?s=cc3eadec75b090dcf038f24184dfe6d52e936a3f&logging=false") { _ in
            VideoPlayerControlAVPlayer(
                VideoPlayerSource(
                    videoURL: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
                    title: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                    imageURL: "https://placehold.co/1920x1080/png",
                    headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                    leadingFootnote: "滴灌通主席李小加就想到了破解方案，兼開發出複利生財的投資模式，有如太極生兩儀、兩儀生四象。薑是老的辣，61歲的他下海創業，把生意經的算盤敲得更為響噹噹。滴灌通主席李小加就想到了破解方案，兼開發出複利生財的投資模式，有如太極生兩儀、兩儀生四象。薑是老的辣，61歲的他下海創業，把生意經的算盤敲得更為響噹噹。",
                    secondFootnote: "",
                    id: 1,
                    videoType: ""
                ),
                playbackStateModel: playbackStateModel
            ) {
                EmptyView()
            }
            //                        CustomVideoPlayer(player: AVPlayer(url: URL(string: $0)!))
            //                        VideoPlayerControlAVPlayer(source)
        }
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    var videoURL: URL
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        player.play()
        return playerController
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

struct Gallery: View {
    var data = [
        MenuItem(
            name: "Video",
            content: {
                AnyView(
                    VideoPlayerView(videoURL: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!)
                        .frame(height: 300)
                )
            }),
        MenuItem(
            name: "屯門33年漫畫小店",
            content: {
                AnyView(
                    TVPOC(url: "kXaRg6wUYK8") { url in
                        YoutubePlayerView(isAutoplay: true) {
                            $0.load(withVideoId: url)
                        }
                    }
                )
            }),
        MenuItem(
            name: "T21 發明人盧煜明",
            content: {
                AnyView(
                    TVPOC(url: "NEpgCftIYmQ") { url in
                        YoutubePlayerView(isAutoplay: true) {
                            $0.load(withVideoId: url)
                        }
                    }
                )
            }),

        MenuItem(
            name: "Vimeo",
            content: {
                AnyView(
                    VimeoPreview()
                )
            }),
        MenuItem(
            name: "ReelsPOC",
            content: {
                AnyView(
                    ReelsPOC()
                )
            }),

        MenuItem(
            name: "Colors",
            content: {
                AnyView(ColorPaletteDemo())
            }),
        MenuItem(
            name: "Fonts",
            content: {
                AnyView(FontsDemo())
            }),
        MenuItem(
            name: "CardView",
            content: {
                AnyView(CardViewGallery())
            }
        ),
        MenuItem(
            name: "ChipGroup",
            content: {
                AnyView(ChipGroupDemo(index: 0))
            }
        )
    ]

    var body: some View {
        NavigationView(content: {
            List {
                ForEach(data) { item in
                    NavigationLink(
                        destination: item.content,
                        label: {
                            Text(item.name)
                        })

                }

                .navigationBarTitle(Text("NMG Mobile Design Library 🏛️"), displayMode: .inline)
                .navigationBarTitleDisplayMode(.inline)
            }

        })
    }
}

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery().environmentObject(ThemeManager.shared)
    }
}
